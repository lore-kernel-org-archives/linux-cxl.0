Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4827C54EBD
	for <linux-cxl@archiver.kernel.org>; Mon,  9 Jan 2023 21:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbjAIVrn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 9 Jan 2023 16:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238051AbjAIVrh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 9 Jan 2023 16:47:37 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539CE395CD
        for <linux-cxl@vger.kernel.org>; Mon,  9 Jan 2023 13:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673300855; x=1704836855;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JrNm1wcEGNZ82q6PQNRq4nkuLV0q+65lrsFeoVtxoL8=;
  b=QkBRiWEH0V5HrFTPXP88LO+91NyR+R7ZucL/nrT/Dx5fiR/8InCdyIC5
   Y7ac8iqy8BYbw3ih66aXazOr8B6vRPEzt/wBCf4tdmlC0RL77sYK3evJ+
   qvQv3hHIWU0RmEIVPSgTW77uQ49Hs7CwbivVGTg8P6JTzJNs7gdEtx5pP
   +PJDfzzqjfBamkHlj7NbbU+alSLMAviCm0lVgg1iNFA9Fn9JKV9V12v8C
   BP1Lh04I9rTF4SyBewXiOV1YUYILDVbfyhvAIPWR5RE5gnexmK7FkZ3MX
   Tt3a50xqGkRgkxsjxBKfQbDD9g4Tg1fibPoS0JLaXZbohk00AZWBzHEgU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="385296969"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="385296969"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 13:47:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="656808571"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="656808571"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.37.174]) ([10.212.37.174])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 13:47:34 -0800
Message-ID: <0e284555-a064-1c1f-0976-aa77f7806afc@intel.com>
Date:   Mon, 9 Jan 2023 14:47:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [ndctl PATCH] cxl/Documentation: Update man page for using 'host'
 names in 'cxl list' filters
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, vishal.l.verma@intel.com
Cc:     linux-cxl@vger.kernel.org
References: <167304471414.912245.3940402514315436804.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <167304471414.912245.3940402514315436804.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 1/6/23 3:38 PM, Dan Williams wrote:
> Commit cf0e0586bf45 ("cxl/list: Add support for filtering by host identifiers")
> added support for filtering based on host device name in addition to CXL
> object name, but it neglected to update the documentation for the same.
> 
> For example, if someone sees a CXL class device in lspci:
> 
> $ lspci | grep CXL
> 35:00.0 CXL: Intel Corporation Device 0d93 (rev 01)
> 
> ...they can use that device name with "cxl list":
> 
> $ # cxl list -BPMu -m 0000:35:00.0
> {
>    "bus":"root0",
>    "provider":"ACPI.CXL",
>    "ports:root0":[
>      {
>        "port":"port1",
>        "host":"pci0000:34",
>        "depth":1,
>        "memdevs:port1":[
>          {
>            "memdev":"mem0",
>            "pmem_size":"512.00 MiB (536.87 MB)",
>            "serial":"0",
>            "host":"0000:35:00.0"
>          }
>        ]
>      }
>    ]
> }
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   Documentation/cxl/cxl-list.txt |   22 +++++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
> index 5cc37d5d0e26..3410d49af2db 100644
> --- a/Documentation/cxl/cxl-list.txt
> +++ b/Documentation/cxl/cxl-list.txt
> @@ -75,6 +75,15 @@ configured.
>   }
>   ----
>   
> +Note that for the -m/--memdev=, -p/--port=, and -e/--endpoint= filters a
> +host device name can be substituted for the CXL object identifier. For
> +-m/--memdev= this is an endpoint PCI device name of the form
> +"DDDD:bb:dd.f" (D: Domain b: Bus d: Device f: Function) (see
> +/sys/bus/pci/devices), for -p/--port= this is an upstream switch port
> +PCI device name of the form "DDDD:bb:dd.f", or a PCI bus name of the
> +form "pciDDDD:bb", and for -e/--endpoint= the host device is CXL memory
> +device object name of the form "memX".
> +
>   The --human option in addition to reformatting some fields to more human
>   friendly strings also unwraps the array to reduce the number of lines of
>   output.
> @@ -119,7 +128,9 @@ OPTIONS
>   -------
>   -m::
>   --memdev=::
> -	Specify CXL memory device name(s), or device id(s), to filter the listing. For example:
> +	Specify CXL memory device name(s) ("mem0"), device id(s) ("0"),
> +	and/or host device name(s) ("0000:35:00.0") to filter the listing. For
> +	example:
>   ----
>   # cxl list -M --memdev="0 mem3 5"
>   [
> @@ -281,10 +292,11 @@ OPTIONS
>   
>   -p::
>   --port=::
> -	Specify CXL Port device name(s), device id(s), and or port type
> -	names to filter the listing. The supported port type names are "root"
> -	and "switch". Note that a bus object is also a port, so the
> -	following two syntaxes are equivalent:
> +	Specify CXL Port device name(s) ("port2"), device id(s) ("2"), host
> +	device name(s) ("pci0000:34"), and / or port type name(s) to filter the
> +	listing. The supported port type names are "root" and "switch". Note
> +	that a bus object is also a port, so the following two syntaxes are
> +	equivalent:
>   ----
>   # cxl list -B
>   # cxl list -P -p root -S
> 
