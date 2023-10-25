Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F3F2D636
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 05:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MAgo2ZXN"
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFE6128
	for <linux-cxl@vger.kernel.org>; Tue, 24 Oct 2023 22:26:17 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5b856d73a12so3973646a12.1
        for <linux-cxl@vger.kernel.org>; Tue, 24 Oct 2023 22:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698211577; x=1698816377; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TYsvkenkOOHMQG0IFPn1E4GNIOMkOOL4/OODSWrd9Q8=;
        b=MAgo2ZXNNdImm22oh4okJFGx5d7TA1M9aJHQzip1dGmWlxJd4qf04RMNCJd8gqo9+t
         UXuKZwMZa59njxcl73I9UXP6c5iZY7zuPNbRCkWHzV9rdta+dkxvo5QzI2MFwWN/LngZ
         oB7ebEFsqeRIaJQjHHoXbvNsdg84Ls6Yb8sPvArmvQJSrWu7HRwGy0Hb/vUGn70H2Wwn
         c7Xof3qfind8/fWuLipvk9buxV41fC8yfcoADnBqbXiwWXSWJfz/ErKIXmCPv8UZyuWJ
         gRbW+A/M7gR/9kXl0faLUsc5gSOnSHMxGUOUbTw3q19NT9Z6HY+BxMKD/uvWFd4v+tah
         vwWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698211577; x=1698816377;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TYsvkenkOOHMQG0IFPn1E4GNIOMkOOL4/OODSWrd9Q8=;
        b=epWuVtHjMTZevW6aHskmAIYHTDllGpM9jUiWz9Shd4R3c2GdgcXHL4bn6zObWgbfgw
         DYBJZX1DEhvDOY8ie/kKlCBSdCRS6YcV3BqfNRpIqeZTdJrgX7IJwl9AcROGxIrC6iSB
         OOqvwcApWWZgc03ZvobqbTV1bOuLO1UmXLOyQcuglBGFiJL7QkKJQLSRGzJu7E0moVVj
         2vxyove2Hyct1M9jFeHjKUe5sc8rXacfACcGpeebdi0CzlTcXPxBpSXgsr3ZdgMAcBaw
         kbwWzMfZViHdQwkyXNWhDb3GBsArgwtd76hz95EhuU5AUmsUSV4Z6B/vfneE1YiX8RjF
         gLYQ==
X-Gm-Message-State: AOJu0YyXnyuRps7dSYgXHKqBl3B4xWjnT2XFK2EqeYeO44Jp7gGcdOEJ
	SV+6tVo+ceNnvFyaYct77SQ=
X-Google-Smtp-Source: AGHT+IFoIV4ClLalYdrVGaeDQ1UOYErb2cqcQaFFYaUBEIi21wc7LPQtu+FfnQLKlirseXsQjNixPg==
X-Received: by 2002:a17:90b:3c4e:b0:27d:2a92:89b2 with SMTP id pm14-20020a17090b3c4e00b0027d2a9289b2mr12830119pjb.33.1698211577146;
        Tue, 24 Oct 2023 22:26:17 -0700 (PDT)
Received: from debian ([2601:641:380:4e50:5e7c:68d3:5ea1:8eb2])
        by smtp.gmail.com with ESMTPSA id bb21-20020a17090b009500b0027d0a60b9c9sm9558236pjb.28.2023.10.24.22.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 22:26:16 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 24 Oct 2023 22:25:53 -0700
To: fan <nifan.cxl@gmail.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"Singh, Naveen" <naveen.c.singh@intel.com>,
	linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com
Subject: Re: Questions about the qemu DCD support in cxl-2023-09-13
Message-ID: <ZTim4UPbe2C-tC_w@debian>
References: <650cc29ab3f64_50d07294e7@iweiny-mobl.notmuch>
 <ZTbN8mAa256JWTFE@debian>
 <ZTgTQs_HJ9Xlb0Ov@debian>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZTgTQs_HJ9Xlb0Ov@debian>

On Tue, Oct 24, 2023 at 11:56:02AM -0700, fan wrote:
> On Mon, Oct 23, 2023 at 12:48:02PM -0700, fan wrote:
> > On Thu, Sep 21, 2023 at 03:24:26PM -0700, Ira Weiny wrote:
> > > Fan,
> > > 
> > > I'm working off of Jonathan's latest CXL branch with the DCD patches.[1]
> > > 
> > > I've been testing various things and so far I have a couple of questions.
> > > 
> > > 1) If the qmp command is used to add extents which overlap other extents
> > >    shouldn't that throw an error?  I don't see any validation of this and
> > >    I would think a real device would reject such a request from the FM.
> > > 
> > > 2) Where is CXLType3Dev->dc.total_extent_count set?  Attempting to add
> > >    extents prior to driver load does not seem to work.  And I think this
> > >    is because total_extent_count is 0 in cmd_dcd_get_dyn_cap_ext_list().
> > > 
> > > Ira
> > > 
> > > [1] https://gitlab.com/jic23/qemu/-/tree/cxl-2023-09-13
> > 
> > Hi Ira,
> > FYI. I have updated the DCD emulation patch series based on feedbacks on
> > the previous version.
> > 
> > The new version is here:
> > https://github.com/moking/qemu-jic-clone/tree/dcd-dev
> > 
> > The code is based on Jonathan's branch cxl-2023-09-26.
> > 
> > The main changes include,
> > 
> > 1. Update cxl_find_dc_region to detect the case the range of
> > the extent cross multiple DC regions.
> > 2. Add comments to explain the checks performed in function
> > cxl_detect_malformed_extent_list. (Jonathan)
> > 3. Minimize the checks in cmd_dcd_add_dyn_cap_rsp.(Jonathan)
> > 4. Update total_extent_count in add/release dynamic capacity response function.
> > (Ira and Jorgen Hansen).
> > 5. Fix the logic issue in test_bits and renamed it to
> > test_any_bits_set to clear its function.
> > 6. Add pending extent list for add/release extent event.
> > 7. When add/release extent response is received, use the pending list to
> > verify the extents are valid.
> > 8. Add test_any_bits_set and cxl_insert_extent_to_extent_list declaration to
> > cxl_device.h so it can be used in different files.
> > 9. Updated ct3d_qmp_cxl_event_log_enc to include dynamic capacity event log type.
> > 10. Extract the functionality to delete extent from extent list to a helper
> > function.
> > 11. Move the update of the bitmap which reflects which blocks are backed with
> > dc extents from the moment when a dc extent is offered to the moment when it
> > is accepted from the host.
> > 
> > I was able to test the DCD code you sent previously, let me know if you
> > find any issues.
> > 
> > Fan
> 
> FYI. 
> 
> Updated the last two commits to drop the extents for pending to
> release as the host can proactively release dc extents so there can be
> no pending-to-release extent list on the device side.
> 
> Fan

Ira located a bug when testing dc extent adding with his latest DCD kernel
code.
The dpa passed in the qmp command is offset relative to the base of the
region where the extent is offered, we need to convert it to address relative
to the base address of the base of the region0 so the bit in the bitmap can
be correctly mapped.

Update the commit (commit 0ad5136: hw/cxl/events: Add qmp interfaces to
add/release dynamic capacity ext…) with the following changes to fix the issue.


diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index ea88b53f41..d51f2ef9f5 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1978,7 +1978,7 @@ static void qmp_cxl_process_dynamic_capacity(const char *path, CxlEventLog log,
		 extents[i].shared_seq = 0;

		 /* No duplicate or overlapped extents are allowed */
-        dpa -= dcd->dc.regions[0].base;
+        dpa = dpa + dcd->dc.regions[rid].base - dcd->dc.regions[0].base;
		 if (test_any_bits_set(blk_bitmap, dpa / min_block_size,
			 len / min_block_size)) {
			 error_setg(errp, "duplicate or overlapped extents are detected");


Fan
