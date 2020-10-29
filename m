Return-Path: <SRS0=M7ZD=EE=vger.kernel.org=linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB6BC4363A
	for <linux-cxl@archiver.kernel.org>; Thu, 29 Oct 2020 14:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9029920838
	for <linux-cxl@archiver.kernel.org>; Thu, 29 Oct 2020 14:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbgJ2Oum (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 29 Oct 2020 10:50:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:12221 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgJ2Oum (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 29 Oct 2020 10:50:42 -0400
IronPort-SDR: sQp+9V4Cg0Z+nkNUjqdte+uju7JWIIVqnBGjbqW/tmhtwxlVtNlaS4HxlmNJDbEudYmBF3oHAl
 H8wsFyB6ELSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9788"; a="186230027"
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="186230027"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 07:50:41 -0700
IronPort-SDR: EeOLeWXq1/EpIasPvIbYor6MTspKWw/bOAqtfkBJX6PB9nGcKdX34wC/jUu6qQ+Dj4WMCCIgmp
 MdZ/Sa1SCvDA==
X-IronPort-AV: E=Sophos;i="5.77,430,1596524400"; 
   d="scan'208";a="323726413"
Received: from tbhaskar-mobl.ger.corp.intel.com (HELO intel.com) ([10.252.138.141])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2020 07:50:41 -0700
Date:   Thu, 29 Oct 2020 07:50:39 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Vikram Sethi <vsethi@nvidia.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Natu, Mahesh" <mahesh.natu@intel.com>,
        "Rudoff, Andy" <andy.rudoff@intel.com>,
        Jeff Smith <JSMITH@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>,
        "jglisse@redhat.com" <jglisse@redhat.com>
Subject: Re: Onlining CXL Type2 device coherent memory
Message-ID: <20201029145039.pwkc3qhr5fkizx4g@intel.com>
References: <BL0PR12MB25321C8689BAFDF8678E5C69BD170@BL0PR12MB2532.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR12MB25321C8689BAFDF8678E5C69BD170@BL0PR12MB2532.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 20-10-28 23:05:48, Vikram Sethi wrote:
> Hello, 
>  
> I wanted to kick off a discussion on how Linux onlining of CXL [1] type 2 device 
> Coherent memory aka Host managed device memory (HDM) will work for type 2 CXL 
> devices which are available/plugged in at boot. A type 2 CXL device can be simply 
> thought of as an accelerator with coherent device memory, that also has a 
> CXL.cache to cache system memory. 
>  
> One could envision that BIOS/UEFI could expose the HDM in EFI memory map 
> as conventional memory as well as in ACPI SRAT/SLIT/HMAT. However, at least 
> on some architectures (arm64) EFI conventional memory available at kernel boot 
> memory cannot be offlined, so this may not be suitable on all architectures. 

If the expectation is that BIOS/UEFI is setting up these regions, the HDM
decoder registers themselves can be read to determine the regions. We'll have to
do this anyway for certain cases.

>  
> Further, the device driver associated with the type 2 device/accelerator may 
> want to save off a chunk of HDM for driver private use. 
> So it seems the more appropriate model may be something like dev dax model 
> where the device driver probe/open calls add_memory_driver_managed, and 
> the driver could choose how much of the HDM it wants to reserve and how 
> much to make generally available for application mmap/malloc. 

To me it seems whether the BIOS reports the HDM in the memory map is an
implementation detail that's up to the platform vendor. It would be unwise for
the device driver, and perhaps the bus driver, to skip verification of the
register programming in the HDM decoders even if it is in the memory map.

>  
> Another thing to think about is whether the kernel relies on UEFI having fully 
> described NUMA proximity domains and end-end NUMA distances for HDM,
> or whether the kernel will provide some infrastructure to make use of the 
> device-local affinity information provided by the device in the Coherent Device 
> Attribute Table (CDAT) via a mailbox, and use that to add a new NUMA node ID
> for the HDM, and with the NUMA distances calculated by adding to the NUMA 
> distance of the host bridge/Root port with the device local distance. At least 
> that's how I think CDAT is supposed to work when kernel doesn't want to rely 
> on BIOS tables.

If/when hotplug is a thing, CDAT will be the only viable mechanism to obtain
this information and so the kernel would have to make use of it. I hadn't really
thought about foregoing BIOS provided tables altogether and only using CDAT.
That's interesting...

The one thing I'll lament about while I'm here is the decision to put CDAT
behind DOE...

>  
> A similar question on NUMA node ID and distances for HDM arises for CXL hotplug. 
> Will the kernel rely on CDAT, and create its own NUMA node ID and patch up 
> distances, or will it rely on BIOS providing PXM domain reserved at boot in 
> SRAT to be used later on hotplug?

I don't have enough knowledge here, but it's an interesting question to me as
well.

