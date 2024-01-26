Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B13AD53
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jan 2024 17:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706290509; cv=none; b=PycNFHBgvK6MUQWodaoa8P3j+S7rx/YQ+gXROSZR0mi6C7MB4JrCb/93F6nqRMbeDnRYm/xXHSAiJdMCL8GWZ16lRBX0fVeXlrYGAzD6aqmzym+SMLUQJT+WBQsPPbBzSRkeDEsZQOmhYuYi8/Hi3O3BnPFozdn7Uj9f/SPRWTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706290509; c=relaxed/simple;
	bh=5TDc2soa250ntk64x23nLAmBYj7R5y3/wK/OUGendv0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BE6OMcxzNONuePUgF4jV6/jnooDrZzBkLlZWZB3XFPO2Pvar3sf3JkumfSkTlWsHl44tJOZLy0wbD/gPdxbhPMeh9G1QCzE+YyEcrFWXJn6iEWbJUdL3If9g/qXTs7/nW9l+A+3/8e3K8Q78kWb/1kcF2Ijnq9/bbLQ7mnCJV7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TM4Wn1nlJz67jVH;
	Sat, 27 Jan 2024 01:32:21 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 592731400D3;
	Sat, 27 Jan 2024 01:35:02 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 17:35:01 +0000
Date: Fri, 26 Jan 2024 17:35:00 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <vishal.l.verma@intel.com>, <fan.ni@samsung.com>,
	<a.manzanares@samsung.com>, <mounika.k@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] hw/cxl: Add Activate FW support
Message-ID: <20240126173500.00006bf5@Huawei.com>
In-Reply-To: <b6qqnuyzxtk7lpbf2duxcmi477wdikrtbnwhzxvg2suhgsofez@gccsm2ee3neu>
References: <20240109070436.21253-1-dave@stgolabs.net>
	<20240109070436.21253-3-dave@stgolabs.net>
	<20240126155407.00005335@Huawei.com>
	<b6qqnuyzxtk7lpbf2duxcmi477wdikrtbnwhzxvg2suhgsofez@gccsm2ee3neu>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 26 Jan 2024 08:57:07 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> On Fri, 26 Jan 2024, Jonathan Cameron wrote:
> 
> >On Mon,  8 Jan 2024 23:04:36 -0800
> >Davidlohr Bueso <dave@stgolabs.net> wrote:
> >  
> >> Per the latest 3.1 spec for supporting firmware activation.
> >> Online mode is supported by the hw but never incurs in a
> >> background operation.
> >>
> >> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>  
> >Hi Davidlohr.
> >
> >One question inline.  
> 
> Thanks for having a look.
> 
> >J  
> >> ---
> >>  hw/cxl/cxl-mailbox-utils.c | 57 ++++++++++++++++++++++++++++++++++++--
> >>  1 file changed, 55 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> >> index 0295ea8b29aa..7878604595dd 100644
> >> --- a/hw/cxl/cxl-mailbox-utils.c
> >> +++ b/hw/cxl/cxl-mailbox-utils.c
> >> @@ -61,6 +61,7 @@ enum {
> >>      FIRMWARE_UPDATE = 0x02,
> >>          #define GET_INFO      0x0
> >>          #define TRANSFER      0x1
> >> +        #define ACTIVATE      0x2
> >>      TIMESTAMP   = 0x03,
> >>          #define GET           0x0
> >>          #define SET           0x1
> >> @@ -852,7 +853,7 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
> >>      fw_info->slots_supported = CXL_FW_SLOTS;
> >>      fw_info->slot_info = (cci->fw.active_slot & 0x7) |
> >>              ((cci->fw.staged_slot & 0x7) << 3);
> >> -    fw_info->caps = 0;
> >> +    fw_info->caps = BIT(0);
> >>
> >>      if (cci->fw.slot[0]) {
> >>          pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSION 0");
> >> @@ -961,6 +962,55 @@ static void __do_firmware_xfer(CXLCCI *cci)
> >>      cci->fw.transfering = false;
> >>  }
> >>
> >> +/* CXL r3.1 section 8.2.9.3.3: Activate FW (Opcode 0202h) */
> >> +static CXLRetCode cmd_firmware_update_activate(const struct cxl_cmd *cmd,
> >> +                                               uint8_t *payload_in,
> >> +                                               size_t len,
> >> +                                               uint8_t *payload_out,
> >> +                                               size_t *len_out,
> >> +                                               CXLCCI *cci)
> >> +{
> >> +    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
> >> +    struct {
> >> +        uint8_t action;
> >> +        uint8_t slot;
> >> +    } QEMU_PACKED *fw_activate;
> >> +
> >> +    if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
> >> +        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER)) {  
> >
> >Why?  Mind you I'm not sure why the get firmware info command is checking
> >the same. This will probably go upstream post DCD so if we do need
> >this check it needs to add an option for a DCD only device.  
> 
> Will remove.
> 
> >  
> >> +        return CXL_MBOX_INTERNAL_ERROR;
> >> +    }
> >> +
> >> +    fw_activate = (void *)payload_in;
> >> +
> >> +    if (fw_activate->slot == 0 ||
> >> +        fw_activate->slot == cci->fw.active_slot ||
> >> +        fw_activate->slot > CXL_FW_SLOTS) {
> >> +        return CXL_MBOX_FW_INVALID_SLOT;
> >> +    }
> >> +
> >> +    /*
> >> +     * Check that an actual fw package is there, otherwise
> >> +     * just become a nop.
> >> +    */  
> >Odd indent.
> >
> >Also, Spec reference would be good for this as I can't
> >immediately see anything beyond the statement about failing
> >to activate.  I assume that path applies if there is a firmware there
> >but loading it fails for some reason and we roll back and for
> >that there is an error code.  
> 
> This case just occurred to me while writing the patch, I could not
> find an answer in the spec.

Let's ping the spec guys for a clarification...
I'll cc you.


Jonathan


> 
> >
> >So I think this should return an error but not obvious if Invalid Input
> >or Invalid Slot.  
> 
> Fine with me, I'll go with Invalid Slot.
> 
> Thanks,
> Davidlohr

