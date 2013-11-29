#
#  $Id: odbcext_virtuoso.rb,v 1.3 2008/04/13 22:46:09 source Exp $
#
#  OpenLink ODBC Adapter for Ruby on Rails
#  Copyright (C) 2006 OpenLink Software
#
#  Permission is hereby granted, free of charge, to any person obtaining
#  a copy of this software and associated documentation files (the
#  "Software"), to deal in the Software without restriction, including
#  without limitation the rights to use, copy, modify, merge, publish,
#  distribute, sublicense, and/or sell copies of the Software, and to
#  permit persons to whom the Software is furnished to do so, subject
#  to the following conditions:
#
#  The above copyright notice and this permission notice shall be
#  included in all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
#  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
#  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
#  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
#  ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
#  CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
#  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

module ODBCExt
  
  # ------------------------------------------------------------------------
  # Mandatory methods
  #
  
  # #last_insert_id must be implemented for any database which returns
  # false from #prefetch_primary_key?
  
  def last_insert_id(table, sequence_name, stmt = nil)
    @logger.unknown("ODBCAdapter#last_insert_id>") if @trace
    @logger.unknown("args=[#{table}]") if @trace
    select_value("SELECT LASTAUTOINC(#{table}) FROM #{table}", 'last_insert_id')    
  end
    
  def primary_key(table = nil)
    primary = indexes(table).detect { |index| index.name.downcase == "primary" }
    if primary
      primary.columns[0]
    else
      raise StandardError, "No valid primary key found for #{table}"
    end
  end

  def encoding
    'ISO-8859-1'
  end

  def dbmsIdentCase(identifier)
    identifier.upcase
  end
  
  def activeRecIdentCase(identifier)
    identifier.downcase
  end

  def quoted_true
    'FALSE'
  end
        
  def quoted_false
    'TRUE'
  end

end