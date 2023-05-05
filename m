Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6BDC77B75
	for <linux-cxl@archiver.kernel.org>; Fri,  5 May 2023 20:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjEEUna (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 5 May 2023 16:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjEEUn3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 5 May 2023 16:43:29 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BA04C38
        for <linux-cxl@vger.kernel.org>; Fri,  5 May 2023 13:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683319409; x=1714855409;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GglSZsrWvhGXwpTBUYsP4WGVI65r91DS94erQH8ZTX0=;
  b=XsSQTeywQ/o+Mf9ePUgX/7XgApoiszi9CKD8qXTmxl+LFKELiXZ0vbTc
   VS93uBGZFawmB8J3FQBMUK1yeyBZbCMGa5QjOzx/MoDnrky378CtQvYl/
   1vO3RPs7PollfR39Jhk/QsnYGBTpCDjopNnfDGPEjk8z0Yv+cFvXosg3I
   9Ctcdg6hSAexZyfQUry6F6JffXyq5NXCyxXMwctSQxn5iZ4yHeR0TnCt6
   dtBnYyR5nVUvKKZBDF/J7u3msd30zVVnO9CefV7LyJTsAaoKLS444PZTW
   jdpQUCq2aGoWdQQOq+j5fjdSebZjt3riM5SoLUj9lV++L4Q8pL7MD602x
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="412536445"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="412536445"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 13:43:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10701"; a="1027645560"
X-IronPort-AV: E=Sophos;i="5.99,253,1677571200"; 
   d="scan'208";a="1027645560"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.77.78]) ([10.212.77.78])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2023 13:43:27 -0700
Message-ID: <852ba578-5f9e-30cf-bcde-19baa6f234bd@intel.com>
Date:   Fri, 5 May 2023 13:43:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 2/3] cxl: Add checksum verification to CDAT from CXL
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
References: <168330433154.1986478.2238692205077357255.stgit@djiang5-mobl3>
 <168330452895.1986478.7758561874383258080.stgit@djiang5-mobl3>
 <hrja6figxyf3dhr24cwp3ofuhrw66tdpwprsih6vahnuggm63r@wsixzfbasmoa>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <hrja6figxyf3dhr24cwp3ofuhrw66tdpwprsih6vahnuggm63r@wsixzfbasmoa>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 5/5/23 12:15 PM, Davidlohr Bueso wrote:
> On Fri, 05 May 2023, Dave Jiang wrote:
> 
>> /**
>>  * read_cdat_data - Read the CDAT data on this port
>>  * @port: Port to read data from
>> @@ -571,9 +581,17 @@ void read_cdat_data(struct cxl_port *port)
>>         /* Don't leave table data allocated on error */
>>         devm_kfree(dev, cdat_table);
>>         dev_err(dev, "CDAT data read error\n");
>> +        return;
> 
> Should this be a separate fixlet?

Yeah I can split that out.
> 
>>     }
>>
>>     port->cdat.table = cdat_table + sizeof(__le32);
>> +    if (cdat_checksum(port->cdat.table, cdat_length)) {
>> +        /* Don't leave table data allocated on error */
>> +        devm_kfree(dev, cdat_table);
>> +        dev_err(dev, "CDAT data checksum error\n");
>> +        return;
>> +    }
>> +
>>     port->cdat.length = cdat_length;
> 
> Upon error, port->cdat should remain consistent (only be set after 
> passing the
> checksum. Ie, wouldn't the following be better?

yup. I'll update.

> 
>        cdat_table += sizeof(__le32);
>        if (cdat_checksum()) {
>           ...
>        }
>        port->cdat.table = cdat_table;
>        port->cdat.length = cdat_length;
> 
> 
> Thanks,
> Davidlohr
