Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469D258229
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jan 2024 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706607902; cv=none; b=l/UVyJH/o6aZweuU9NNYGRgIg0SPcMc46hg38AdLues+4L3XSNXrdkTUAEq2jMrKZq0KhDPWDIC8zZ3h3bPW5qQgvSM4DODLc8vi3Wa4vEIJqlCVn+OqnAH6P/DiEi4ZiufzhlgucHpeNcSFcOE2f3nAMt2yq0W6X4NKOrI71y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706607902; c=relaxed/simple;
	bh=vMzFMf6nniTfFvzgdv7XmNvakVf4HWK4LHdlaiTgUfI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pEsaWUi5uONvhd4wWAbt4kB0ur3W2r7ME4DpGXTEITLLMEAOUUkaG4sceUrMxb9RqD2Ku0VDw0wu5bgIwExyRsJ1D860SswBThoN1vCmj8/8n4EsmQQsHz5YuyzvDR1w5S/Aj6RvJVXdR3EXqbicVc1+He859aWVPq4eZArW50k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TPKv50DgMz67MmR;
	Tue, 30 Jan 2024 17:41:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 09A5E140B38;
	Tue, 30 Jan 2024 17:44:58 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Jan
 2024 09:44:57 +0000
Date: Tue, 30 Jan 2024 09:44:56 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: fan <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	<nifan@outlook.com>, <jim.harris@samsung.com>, "Fan Ni" <fan.ni@samsung.com>
Subject: Re: [PATCH v3 2/9] hw/cxl/cxl-mailbox-utils: Add dynamic capacity
 region representative and mailbox command support
Message-ID: <20240130094456.00003e6e@Huawei.com>
In-Reply-To: <ZbfhN5kVT7W3jvoU@debian>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
	<20231107180907.553451-3-nifan.cxl@gmail.com>
	<20240124145118.00002f7d@Huawei.com>
	<ZbfhN5kVT7W3jvoU@debian>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 29 Jan 2024 09:32:39 -0800
fan <nifan.cxl@gmail.com> wrote:

> On Wed, Jan 24, 2024 at 02:51:18PM +0000, Jonathan Cameron wrote:
> > On Tue,  7 Nov 2023 10:07:06 -0800
> > nifan.cxl@gmail.com wrote:
> >   
> > > From: Fan Ni <fan.ni@samsung.com>
> > > 
> > > Per cxl spec 3.0, add dynamic capacity region representative based on
> > > Table 8-126 and extend the cxl type3 device definition to include dc region
> > > information. Also, based on info in 8.2.9.8.9.1, add 'Get Dynamic Capacity
> > > Configuration' mailbox support.
> > > 
> > > Note: decode_len of a dc region is aligned to 256*MiB, need to be divided by
> > > 256 * MiB before returned to the host for "Get Dynamic Capacity Configuration"
> > > mailbox command.
> > > 
> > > Signed-off-by: Fan Ni <fan.ni@samsung.com>  
> > 
> > Hi Fan,
> > 
> > I'm looking at how to move these much earlier in my tree on basis that
> > they should be our main focus for merging in this QEMU cycle.
> > 
> > Whilst I do that rebase, I'm taking a closer look at the code.
> > I'm targetting rebasing on upstream qemu + the two patch sets I just
> > sent out:
> > [PATCH 00/12 qemu] CXL emulation fixes and minor cleanup. 
> > [PATCH 0/5 qemu] hw/cxl: Update CXL emulation to reflect and reference r3.1
> > 
> > It would be good to document why these commands should be optional (which I think
> > comes down to the annoying fact that Get Dynamic Capacity Configuration isn't
> > allowed to return 0 regions, but instead should not be available as a command
> > if DCD isn't supported.
> > 
> > Note this requires us to carry Gregory's patches to make the CCI command list
> > constructed at runtime rather than baked in ahead of this set.
> > 
> > So another question is should we jump directly to the r3.1 version of DCD?
> > I think we probably should as it includes some additions that are necessary
> > for a bunch of the potential use cases.
> >   
> 
> Hi Jonathan,
> 
> Thanks for taking time to review the patches. 
> I will redo the patches and make them align with cxl spec v3.1. Before
> that, I need some clarifications.
> As you mentioned above, for the next version, I will use upstream qemu + the
> two patchsets you mentioned above as base, that is clear to me.
> However, you mentioned Gregory's patches above constructing CCI command list
> at runtime, I think you meant we should also include that patchset
> before DCD so if DCD is not supported, the Get Dynamic capacity
> configuration command will not be available at the first place, am I
> right? If so, could you point me to the latest patches of the mentioned
> CCI work I should use? I see the CCI rework patches, but not sure if we
> should have them all or they are the latest.

only the two before DCD in this tree.
https://gitlab.com/jic23/qemu/-/commits/cxl-2024-26-01-draft/?ref_type=heads

hw/cxl/mailbox: change CCI cmd set structure to be a member, not a reference 
hw/cxl/mailbox: interface to add CCI commands to an existing CCI 

There is one more sneaky fix on that tree that isn't related to these that I
put behind the spec version updates because it was a pain to rebase.
So fine to ignore that one.

Everything else ahead of DCD has been sent to the list for a merge hopefully.

Jonathan

> 
> Thanks,
> Fan
> 
> >   
> > > ---
> > >  hw/cxl/cxl-mailbox-utils.c  | 80 +++++++++++++++++++++++++++++++++++++
> > >  hw/mem/cxl_type3.c          |  6 +++
> > >  include/hw/cxl/cxl_device.h | 17 ++++++++
> > >  3 files changed, 103 insertions(+)
> > > 
> > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > > index 8eceedfa87..f80dd6474f 100644
> > > --- a/hw/cxl/cxl-mailbox-utils.c
> > > +++ b/hw/cxl/cxl-mailbox-utils.c
> > > @@ -80,6 +80,8 @@ enum {
> > >          #define GET_POISON_LIST        0x0
> > >          #define INJECT_POISON          0x1
> > >          #define CLEAR_POISON           0x2
> > > +    DCD_CONFIG  = 0x48,
> > > +        #define GET_DC_CONFIG          0x0
> > >      PHYSICAL_SWITCH = 0x51,
> > >          #define IDENTIFY_SWITCH_DEVICE      0x0
> > >          #define GET_PHYSICAL_PORT_STATE     0x1
> > > @@ -1210,6 +1212,74 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
> > >      return CXL_MBOX_SUCCESS;
> > >  }
> > >  
> > > +/*
> > > + * CXL r3.0 section 8.2.9.8.9.1: Get Dynamic Capacity Configuration  
> > 
> > As per the patch set I just sent out, I want to standardize on references
> > to r3.1 because it's all that is easy to get.  However if we decide to r3.0
> > DCD first the upgrade it later, then clearly these need to stick to r3.0 for
> > now.
> >   
> > > + * (Opcode: 4800h)
> > > + */
> > > +static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
> > > +                                             uint8_t *payload_in,
> > > +                                             size_t len_in,
> > > +                                             uint8_t *payload_out,
> > > +                                             size_t *len_out,
> > > +                                             CXLCCI *cci)
> > > +{
> > > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > > +    struct get_dyn_cap_config_in_pl {
> > > +        uint8_t region_cnt;
> > > +        uint8_t start_region_id;
> > > +    } QEMU_PACKED;
> > > +
> > > +    struct get_dyn_cap_config_out_pl {
> > > +        uint8_t num_regions;
> > > +        uint8_t rsvd1[7];  
> > 
> > This changed in r3.1 (errata? - I haven't checked)
> > Should be 'regions returned' in first byte.
> >   
> > > +        struct {
> > > +            uint64_t base;
> > > +            uint64_t decode_len;
> > > +            uint64_t region_len;
> > > +            uint64_t block_size;
> > > +            uint32_t dsmadhandle;  
> >   
> > > +            uint8_t flags;
> > > +            uint8_t rsvd2[3];
> > > +        } QEMU_PACKED records[];  
> > 
> > There are two fields after this as well.
> > Total number of supported extents and number of available extents.
> > 
> > That annoyingly means we can't use the structure to tell us where
> > to find all the fields...
> > 
> >   
> > > +    } QEMU_PACKED;
> > > +
> > > +    struct get_dyn_cap_config_in_pl *in = (void *)payload_in;
> > > +    struct get_dyn_cap_config_out_pl *out = (void *)payload_out;
> > > +    uint16_t record_count = 0, i;  
> > 
> > Better to split that on to 2 lines. Never hide setting a value
> > in the middle of a set of declarations.
> >   
> > > +    uint16_t out_pl_len;
> > > +    uint8_t start_region_id = in->start_region_id;
> > > +
> > > +    if (start_region_id >= ct3d->dc.num_regions) {
> > > +        return CXL_MBOX_INVALID_INPUT;
> > > +    }
> > > +
> > > +    record_count = MIN(ct3d->dc.num_regions - in->start_region_id,
> > > +            in->region_cnt);
> > > +
> > > +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);  
> > 
> > For r3.1 + 8 for the two trailing fields.
> >   
> > > +    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> > > +
> > > +    memset(out, 0, out_pl_len);  
> > 
> > As part of the cci rework we started zeroing the whole mailbox payload space
> > after copying out the input payload.
> > https://elixir.bootlin.com/qemu/latest/source/hw/cxl/cxl-device-utils.c#L204
> > 
> > So shouldn't need this (unless we have a bug)
> > 
> > Jonathan  

