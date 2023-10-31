Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6D620B3A
	for <linux-cxl@vger.kernel.org>; Tue, 31 Oct 2023 17:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScieiuAf"
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02B7DA
	for <linux-cxl@vger.kernel.org>; Tue, 31 Oct 2023 10:44:48 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-579de633419so57980237b3.3
        for <linux-cxl@vger.kernel.org>; Tue, 31 Oct 2023 10:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698774288; x=1699379088; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mE3lK5hPZIK17eIucMEUfCgzp6ul7cGl6KWb78SvjpY=;
        b=ScieiuAfRW7jx/A+YvzfAfX+nbOXEcwFH+3R/CDsu6siBYDY5BSFlGGckL8frVXntl
         GGS9LXUdjJ6KZwXQqVHCHY57iJwZ4ygONju8GJdBFm77I2o0i0kHbpNcq+v16JbfzHid
         mxtDoBJKlIWVZLo13Dl03LrufoQBUeK4TYC5SIsIj6TyFQCYvZm//G8monzGSC2Bj9Z1
         SeGIzQEtxXk2M5V2L9MyOKRNlQiY2pCU5Hs3GlaZjZbH1UYFYcCD7Ac1UqGhdidBnnYG
         ymEABYhNN4DiSAUIfkkPziFxn1qlrqXVoDPR0LHR6/XZV+6qktUphn1spOHvPpX3fvDi
         TDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698774288; x=1699379088;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mE3lK5hPZIK17eIucMEUfCgzp6ul7cGl6KWb78SvjpY=;
        b=GLf4fNg8+rogBhsklxpyJhySXj8IAQnmgAT5BVZkOc9Oh/fSOEI/apUNOCqr21hbfP
         hxs2ABXnVorzrJPI3xAUbu8t3iSheNnUijwx6UNRk2lvUHBs4qCWh/7gv3UL/GNlAPWf
         8ydUg2p0Us8vf9OEcaFzdRLnBftywTHcQDKZU4b/xkVg2FLLK45z8g4UCsuDHm2+RFzM
         Y6+bC78EtqvE8EpfHlFYelUuw86dDZhV+I4/n9LUjyodUCUTIorTthotr34VTb8bB2b+
         vHf9jZieHiRBIsKgQP/4+JY0F8btb58iPNKCjM6AgtTNl8vuqhl9oodSwIZjr5zAuMGi
         QNYg==
X-Gm-Message-State: AOJu0Yy/7Ik/201N323mGcJsEWLdWJ5uWSxKyPwe0dUExAJXH+2Vfcxu
	1s04UmhxUA0bxZenS2JoDrc=
X-Google-Smtp-Source: AGHT+IG+H4xY7VZNz/71fZvQSXRHmqL0k+p5Vaxjte54Xu8RBtv2aokHypk7HBYQMMHfvyMaGh9RhQ==
X-Received: by 2002:a0d:d846:0:b0:5af:abe1:3d4b with SMTP id a67-20020a0dd846000000b005afabe13d4bmr13580654ywe.5.1698774287872;
        Tue, 31 Oct 2023 10:44:47 -0700 (PDT)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id w6-20020a818606000000b0059a34cfa2a5sm1076368ywf.67.2023.10.31.10.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 10:44:47 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 31 Oct 2023 10:44:31 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: fan <nifan.cxl@gmail.com>, linux-cxl@vger.kernel.org,
	a.manzanares@samsung.com, Ira Weiny <ira.weiny@intel.com>,
	Fan Ni <fan.ni@samsung.com>,
	"Singh, Naveen" <naveen.c.singh@intel.com>, dave@stgolabs.net,
	nmtadam.samsung@gmail.com
Subject: Re: Questions about the qemu DCD support in cxl-2023-09-13
Message-ID: <ZUE8_8Yi0OtLbRyi@debian>
References: <650cc29ab3f64_50d07294e7@iweiny-mobl.notmuch>
 <ZTbN8mAa256JWTFE@debian>
 <ZTgTQs_HJ9Xlb0Ov@debian>
 <ZTim4UPbe2C-tC_w@debian>
 <20231026100121.00007100@Huawei.com>
 <20231026175802.00001cfc@Huawei.com>
 <ZTvmesV_Uc_0Zf6j@debian>
 <20231031171846.000050d1@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231031171846.000050d1@Huawei.com>

On Tue, Oct 31, 2023 at 05:18:46PM +0000, Jonathan Cameron wrote:
> On Fri, 27 Oct 2023 09:34:02 -0700
> fan <nifan.cxl@gmail.com> wrote:
> 
> > On Thu, Oct 26, 2023 at 05:58:02PM +0100, Jonathan Cameron wrote:
> > > On Thu, 26 Oct 2023 10:01:21 +0100
> > > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> > >   
> > > > On Tue, 24 Oct 2023 22:25:53 -0700
> > > > fan <nifan.cxl@gmail.com> wrote:
> > > >   
> > > > > On Tue, Oct 24, 2023 at 11:56:02AM -0700, fan wrote:    
> > > > > > On Mon, Oct 23, 2023 at 12:48:02PM -0700, fan wrote:      
> > > > > > > On Thu, Sep 21, 2023 at 03:24:26PM -0700, Ira Weiny wrote:      
> > > > > > > > Fan,
> > > > > > > > 
> > > > > > > > I'm working off of Jonathan's latest CXL branch with the DCD patches.[1]
> > > > > > > > 
> > > > > > > > I've been testing various things and so far I have a couple of questions.
> > > > > > > > 
> > > > > > > > 1) If the qmp command is used to add extents which overlap other extents
> > > > > > > >    shouldn't that throw an error?  I don't see any validation of this and
> > > > > > > >    I would think a real device would reject such a request from the FM.
> > > > > > > > 
> > > > > > > > 2) Where is CXLType3Dev->dc.total_extent_count set?  Attempting to add
> > > > > > > >    extents prior to driver load does not seem to work.  And I think this
> > > > > > > >    is because total_extent_count is 0 in cmd_dcd_get_dyn_cap_ext_list().
> > > > > > > > 
> > > > > > > > Ira
> > > > > > > > 
> > > > > > > > [1] https://gitlab.com/jic23/qemu/-/tree/cxl-2023-09-13      
> > > > > > > 
> > > > > > > Hi Ira,
> > > > > > > FYI. I have updated the DCD emulation patch series based on feedbacks on
> > > > > > > the previous version.
> > > > > > > 
> > > > > > > The new version is here:
> > > > > > > https://github.com/moking/qemu-jic-clone/tree/dcd-dev
> > > > > > > 
> > > > > > > The code is based on Jonathan's branch cxl-2023-09-26.
> > > > > > > 
> > > > > > > The main changes include,
> > > > > > > 
> > > > > > > 1. Update cxl_find_dc_region to detect the case the range of
> > > > > > > the extent cross multiple DC regions.
> > > > > > > 2. Add comments to explain the checks performed in function
> > > > > > > cxl_detect_malformed_extent_list. (Jonathan)
> > > > > > > 3. Minimize the checks in cmd_dcd_add_dyn_cap_rsp.(Jonathan)
> > > > > > > 4. Update total_extent_count in add/release dynamic capacity response function.
> > > > > > > (Ira and Jorgen Hansen).
> > > > > > > 5. Fix the logic issue in test_bits and renamed it to
> > > > > > > test_any_bits_set to clear its function.
> > > > > > > 6. Add pending extent list for add/release extent event.
> > > > > > > 7. When add/release extent response is received, use the pending list to
> > > > > > > verify the extents are valid.
> > > > > > > 8. Add test_any_bits_set and cxl_insert_extent_to_extent_list declaration to
> > > > > > > cxl_device.h so it can be used in different files.
> > > > > > > 9. Updated ct3d_qmp_cxl_event_log_enc to include dynamic capacity event log type.
> > > > > > > 10. Extract the functionality to delete extent from extent list to a helper
> > > > > > > function.
> > > > > > > 11. Move the update of the bitmap which reflects which blocks are backed with
> > > > > > > dc extents from the moment when a dc extent is offered to the moment when it
> > > > > > > is accepted from the host.
> > > > > > > 
> > > > > > > I was able to test the DCD code you sent previously, let me know if you
> > > > > > > find any issues.
> > > > > > > 
> > > > > > > Fan      
> > > > > > 
> > > > > > FYI. 
> > > > > > 
> > > > > > Updated the last two commits to drop the extents for pending to
> > > > > > release as the host can proactively release dc extents so there can be
> > > > > > no pending-to-release extent list on the device side.
> > > > > > 
> > > > > > Fan      
> > > > > 
> > > > > Ira located a bug when testing dc extent adding with his latest DCD kernel
> > > > > code.
> > > > > The dpa passed in the qmp command is offset relative to the base of the
> > > > > region where the extent is offered, we need to convert it to address relative
> > > > > to the base address of the base of the region0 so the bit in the bitmap can
> > > > > be correctly mapped.
> > > > > 
> > > > > Update the commit (commit 0ad5136: hw/cxl/events: Add qmp interfaces to
> > > > > add/release dynamic capacity ext…) with the following changes to fix the issue.    
> > > > 
> > > > Hi Fan,
> > > > 
> > > > I hit this whilst reusing some of your code for the fmapi initiate add DC
> > > > command.   Try adding an empty extent list..
> > > > 
> > > > "extents": []
> > > > 
> > > > boom.
> > > > 
> > > > Definitely need to reject that input :)  
> > > 
> > > Fan,
> > > 
> > > Another thing I noticed...
> > > 
> > > I would not provide a more flexible QMP interface than the FMAPI interfaces.
> > > The key thing I've noticed so far is no need to provide option for a list
> > > of extents in different regions.  Just provide them as separate commands if that
> > > is what is wanted.   That is drop the region-id in QMP out of the extent and
> > > put alongside path in the top level arguements.
> > > 
> > > { "execute": "cxl-add-dynamic-capcity",
> > >   "arguements": {
> > > 	"path": "cxl-mem1",
> > > 	"region-id": 3,
> > > 	"extents": [ { "dpa": 0, "len": 6 } ] }}
> > >   }
> > > 
> > > 
> > >   
> > > > 
> > > > Jonathan  
> > 
> > Hi Jonathan,
> > 
> > I updated my branch with the following changes:
> > 1. Add code to detect and reject QMP requests without any extents;
> > 2. Add code to detect and reject QMP requests where the extent len is 0.
> > 3. Change the QMP interface as you suggested above and moved the
> > region-id out of extents and now each command only takes care of extent
> > add/release request in a single region.
> > 4. Change the region bitmap length from decode_len to len.
> 
> Great. Looking at what I think is your newest implementation.
> 
> dpa is used qmp_cxl_process_dynamic_capacity() for various things that aren't
> the device physical address (aren't relative to start of device).
> That's confusing at times.  The FMAPI commands are all in DPA so I got a bit
> lost.  I think you should do all the checks based on actual DPA (so for some
> you will then need to subtract the region base).

The dpa is only used as the offset to the base of current region, not to the
start of the device. We can change it to offset if it causes confusion.

> 
> Now you only have one region, you can do the checking of overlap in that function
> in one bit per block_size - whatever the block size happens to be.

All the checks now are within a single region, and we use one bit per
block_size already in the code.

...

blk_bitmap = bitmap_new(dcd->dc.regions[rid].len / block_size);

https://github.com/moking/qemu-jic-clone/blob/dcd-dev/hw/mem/cxl_type3.c#L2044

One more thing, I forgot to update the interface in the stub.c file for
the new QMP interface, will update.

Fan


...

> 
> Otherwise this bit looks good to me.  My initial FMAPI stuff is going to
> be a bit of a hack on top, but the aim is to illustrate where there
> might be shared code rather than end up with a proper clean result.
> 
> Jonathan
> 
> > 
> > Fan
> > 
> > > > 
> > > >   
> > > > > 
> > > > > 
> > > > > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > > > > index ea88b53f41..d51f2ef9f5 100644
> > > > > --- a/hw/mem/cxl_type3.c
> > > > > +++ b/hw/mem/cxl_type3.c
> > > > > @@ -1978,7 +1978,7 @@ static void qmp_cxl_process_dynamic_capacity(const char *path, CxlEventLog log,
> > > > > 		 extents[i].shared_seq = 0;
> > > > > 
> > > > > 		 /* No duplicate or overlapped extents are allowed */
> > > > > -        dpa -= dcd->dc.regions[0].base;
> > > > > +        dpa = dpa + dcd->dc.regions[rid].base - dcd->dc.regions[0].base;
> > > > > 		 if (test_any_bits_set(blk_bitmap, dpa / min_block_size,
> > > > > 			 len / min_block_size)) {
> > > > > 			 error_setg(errp, "duplicate or overlapped extents are detected");
> > > > > 
> > > > > 
> > > > > Fan
> > > > >     
> > > > 
> > > > 
> > > >   
> > >   
> > 
> > 
> 
