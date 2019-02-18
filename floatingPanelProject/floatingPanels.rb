#---
# Excerpted from "FXRuby: Create Lean and Mean GUIs with Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/fxruby for more book information.
#---
require 'fox16'

include Fox

class MenuExample < FXMainWindow
  def initialize(app)
    super(app, "Menus Example", :width => 400, :height => 200)


    tool_bar_shell = FXToolBarShell.new(self)   


    # dock sites that provide places for the toolbar to land when it’s ready to come back home
    # The user can drag the floating toolbar to either of these positions on
    # the main window, and it will reattach itself (dock) there.
    top_dock_site = FXDockSite.new(self,      
      :opts => LAYOUT_FILL_X|LAYOUT_SIDE_TOP)
    bottom_dock_site = FXDockSite.new(self,
      :opts => LAYOUT_FILL_X|LAYOUT_SIDE_BOTTOM)

    # creating the tool bar
    tool_bar = FXToolBar.new(top_dock_site, tool_bar_shell,
      :opts => PACK_UNIFORM_WIDTH|FRAME_RAISED|LAYOUT_FILL_X)

    #a “grip,” a handle that the user can grab to tear the toolbar away from the dock site
    FXToolBarGrip.new(tool_bar,
      :target => tool_bar, :selector => FXToolBar::ID_TOOLBARGRIP,
      :opts => TOOLBARGRIP_DOUBLE)

    # load icons  
    new_icon = load_icon("filenew.png")
    open_icon= load_icon("fileopen.png")
    save_icon = load_icon("filesave.png")
    save_as_icon = load_icon("filesaveas.png")


    # create btns and add icons to them
    new_button = FXButton.new(tool_bar,
      "\tNew\tCreate new document.",
      :icon => new_icon)
    open_button = FXButton.new(tool_bar,
      "\tOpen\tOpen document file.",
      :icon => open_icon)
    save_button = FXButton.new(tool_bar,
      "\tSave\tSave document.",
      :icon => save_icon)
    save_as_button = FXButton.new(tool_bar,
      "\tSave As\tSave document to another file.",
      :icon => save_as_icon)

  end
  
  #load image function
  def load_icon(filename)
    icon = nil
    File.open(filename, "rb") do |io|
      icon = FXPNGIcon.new(app, io.read)
      icon.scale(100,100)
    end
    icon
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

if __FILE__ == $0
  FXApp.new do |app|
    MenuExample.new(app)
    app.create
    app.run
  end
end