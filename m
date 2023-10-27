Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94FC39842
	for <linux-cxl@vger.kernel.org>; Fri, 27 Oct 2023 16:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUIgfY09"
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0EB3116
	for <linux-cxl@vger.kernel.org>; Fri, 27 Oct 2023 09:34:28 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6bd73395bceso1671545b3a.0
        for <linux-cxl@vger.kernel.org>; Fri, 27 Oct 2023 09:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698424468; x=1699029268; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=he9kZEu2zAoBb0Fgvh0NEGNs6YazgAcKSPIlArJ7H0s=;
        b=gUIgfY09l9ZPrQJIKicf+mLV1WxKSTJkzyiAE/8ooux9/Nc1IYR4Jy6f5tiBubk6Ay
         cbTohpXA5EJ1wX+i27yescquQq+VJcPXx2GWk/buuSNnvTBmuUcUgkwFpgCZoAh+5GlN
         OMl1thPzJUasVCeHyXtWI7PWIX2EkmAUQD4oyF1/bZBg6eV7QfZXGRw4Dozjs+eBa4w6
         NZl1tHfEyx65qZNxlm/gm0v1ReawzuHkieZxbcjkwcmHD9uSxtQe92UlK94zaU9d+iRz
         4XBpaORVt1IQniYMqi8SRnwW+R1YbeK6xnyRi0AL4AKyQUzzFdTPDUM+qvkgDcsBNr3A
         5xHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698424468; x=1699029268;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=he9kZEu2zAoBb0Fgvh0NEGNs6YazgAcKSPIlArJ7H0s=;
        b=RTEzCWmYu14/GoI+wCmwYNLfADGrKc9AoNfMob9tkkKTzbGZ9uiKGJnnhL9Il7fApE
         8FTA73kYyi4XaXOdqUw6wOpYS2TXZBGDjmB8AeqTD3hNK0DDqXVERfS6HaDOjqk1OeyX
         l2CJwn4PLdw+lbfLgH+S08Szs9GBpAzc8qzo17oDiTKzRdwdmcJZSisap78eWegoXcUA
         uDunfZiFZ+Dmz779TDEuyJVYtLCR7i4oxs8+JXzfl69VNL5bu0EjTWsT5FnN99ckPdT4
         3OgLAu35Gtei375zGDYuJZ3SWl+TjYqAZmjUqMfld3apS1zudrNvsalBmdHizXgIvTRZ
         luPw==
X-Gm-Message-State: AOJu0YxqpvuanhdKb10UmQlzdFuJFG4RQc+A3yZXEnsitYhy9PQVXmWT
	CknJP0hB44BxkkabGG8nmGnue/Cx4RI=
X-Google-Smtp-Source: AGHT+IHp3sM+r/hodG/A0u6THwjlpWlum7mQfzsthyz4IessqgOl/J5ijxNB8+eJTap8ykWX7jz+GQ==
X-Received: by 2002:a05:6a00:114e:b0:68a:582b:6b62 with SMTP id b14-20020a056a00114e00b0068a582b6b62mr3628710pfm.7.1698424468216;
        Fri, 27 Oct 2023 09:34:28 -0700 (PDT)
Received: from debian ([2601:641:380:4e50:5e7c:68d3:5ea1:8eb2])
        by smtp.gmail.com with ESMTPSA id y11-20020aa79e0b000000b0069029a3196dsm1575339pfq.184.2023.10.27.09.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 09:34:27 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 27 Oct 2023 09:34:02 -0700
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: fan <nifan.cxl@gmail.com>, linux-cxl@vger.kernel.org,
	a.manzanares@samsung.com, Ira Weiny <ira.weiny@intel.com>,
	Fan Ni <fan.ni@samsung.com>,
	"Singh, Naveen" <naveen.c.singh@intel.com>, dave@stgolabs.net,
	nmtadam.samsung@gmail.com
Subject: Re: Questions about the qemu DCD support in cxl-2023-09-13
Message-ID: <ZTvmesV_Uc_0Zf6j@debian>
References: <650cc29ab3f64_50d07294e7@iweiny-mobl.notmuch>
 <ZTbN8mAa256JWTFE@debian>
 <ZTgTQs_HJ9Xlb0Ov@debian>
 <ZTim4UPbe2C-tC_w@debian>
 <20231026100121.00007100@Huawei.com>
 <20231026175802.00001cfc@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231026175802.00001cfc@Huawei.com>

On Thu, Oct 26, 2023 at 05:58:02PM +0100, Jonathan Cameron wrote:
> On Thu, 26 Oct 2023 10:01:21 +0100
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Tue, 24 Oct 2023 22:25:53 -0700
> > fan <nifan.cxl@gmail.com> wrote:
> > 
> > > On Tue, Oct 24, 2023 at 11:56:02AM -0700, fan wrote:  
> > > > On Mon, Oct 23, 2023 at 12:48:02PM -0700, fan wrote:    
> > > > > On Thu, Sep 21, 2023 at 03:24:26PM -0700, Ira Weiny wrote:    
> > > > > > Fan,
> > > > > > 
> > > > > > I'm working off of Jonathan's latest CXL branch with the DCD patches.[1]
> > > > > > 
> > > > > > I've been testing various things and so far I have a couple of questions.
> > > > > > 
> > > > > > 1) If the qmp command is used to add extents which overlap other extents
> > > > > >    shouldn't that throw an error?  I don't see any validation of this and
> > > > > >    I would think a real device would reject such a request from the FM.
> > > > > > 
> > > > > > 2) Where is CXLType3Dev->dc.total_extent_count set?  Attempting to add
> > > > > >    extents prior to driver load does not seem to work.  And I think this
> > > > > >    is because total_extent_count is 0 in cmd_dcd_get_dyn_cap_ext_list().
> > > > > > 
> > > > > > Ira
> > > > > > 
> > > > > > [1] https://gitlab.com/jic23/qemu/-/tree/cxl-2023-09-13    
> > > > > 
> > > > > Hi Ira,
> > > > > FYI. I have updated the DCD emulation patch series based on feedbacks on
> > > > > the previous version.
> > > > > 
> > > > > The new version is here:
> > > > > https://github.com/moking/qemu-jic-clone/tree/dcd-dev
> > > > > 
> > > > > The code is based on Jonathan's branch cxl-2023-09-26.
> > > > > 
> > > > > The main changes include,
> > > > > 
> > > > > 1. Update cxl_find_dc_region to detect the case the range of
> > > > > the extent cross multiple DC regions.
> > > > > 2. Add comments to explain the checks performed in function
> > > > > cxl_detect_malformed_extent_list. (Jonathan)
> > > > > 3. Minimize the checks in cmd_dcd_add_dyn_cap_rsp.(Jonathan)
> > > > > 4. Update total_extent_count in add/release dynamic capacity response function.
> > > > > (Ira and Jorgen Hansen).
> > > > > 5. Fix the logic issue in test_bits and renamed it to
> > > > > test_any_bits_set to clear its function.
> > > > > 6. Add pending extent list for add/release extent event.
> > > > > 7. When add/release extent response is received, use the pending list to
> > > > > verify the extents are valid.
> > > > > 8. Add test_any_bits_set and cxl_insert_extent_to_extent_list declaration to
> > > > > cxl_device.h so it can be used in different files.
> > > > > 9. Updated ct3d_qmp_cxl_event_log_enc to include dynamic capacity event log type.
> > > > > 10. Extract the functionality to delete extent from extent list to a helper
> > > > > function.
> > > > > 11. Move the update of the bitmap which reflects which blocks are backed with
> > > > > dc extents from the moment when a dc extent is offered to the moment when it
> > > > > is accepted from the host.
> > > > > 
> > > > > I was able to test the DCD code you sent previously, let me know if you
> > > > > find any issues.
> > > > > 
> > > > > Fan    
> > > > 
> > > > FYI. 
> > > > 
> > > > Updated the last two commits to drop the extents for pending to
> > > > release as the host can proactively release dc extents so there can be
> > > > no pending-to-release extent list on the device side.
> > > > 
> > > > Fan    
> > > 
> > > Ira located a bug when testing dc extent adding with his latest DCD kernel
> > > code.
> > > The dpa passed in the qmp command is offset relative to the base of the
> > > region where the extent is offered, we need to convert it to address relative
> > > to the base address of the base of the region0 so the bit in the bitmap can
> > > be correctly mapped.
> > > 
> > > Update the commit (commit 0ad5136: hw/cxl/events: Add qmp interfaces to
> > > add/release dynamic capacity ext…) with the following changes to fix the issue.  
> > 
> > Hi Fan,
> > 
> > I hit this whilst reusing some of your code for the fmapi initiate add DC
> > command.   Try adding an empty extent list..
> > 
> > "extents": []
> > 
> > boom.
> > 
> > Definitely need to reject that input :)
> 
> Fan,
> 
> Another thing I noticed...
> 
> I would not provide a more flexible QMP interface than the FMAPI interfaces.
> The key thing I've noticed so far is no need to provide option for a list
> of extents in different regions.  Just provide them as separate commands if that
> is what is wanted.   That is drop the region-id in QMP out of the extent and
> put alongside path in the top level arguements.
> 
> { "execute": "cxl-add-dynamic-capcity",
>   "arguements": {
> 	"path": "cxl-mem1",
> 	"region-id": 3,
> 	"extents": [ { "dpa": 0, "len": 6 } ] }}
>   }
> 
> 
> 
> > 
> > Jonathan

Hi Jonathan,

I updated my branch with the following changes:
1. Add code to detect and reject QMP requests without any extents;
2. Add code to detect and reject QMP requests where the extent len is 0.
3. Change the QMP interface as you suggested above and moved the
region-id out of extents and now each command only takes care of extent
add/release request in a single region.
4. Change the region bitmap length from decode_len to len.

Fan

> > 
> > 
> > > 
> > > 
> > > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > > index ea88b53f41..d51f2ef9f5 100644
> > > --- a/hw/mem/cxl_type3.c
> > > +++ b/hw/mem/cxl_type3.c
> > > @@ -1978,7 +1978,7 @@ static void qmp_cxl_process_dynamic_capacity(const char *path, CxlEventLog log,
> > > 		 extents[i].shared_seq = 0;
> > > 
> > > 		 /* No duplicate or overlapped extents are allowed */
> > > -        dpa -= dcd->dc.regions[0].base;
> > > +        dpa = dpa + dcd->dc.regions[rid].base - dcd->dc.regions[0].base;
> > > 		 if (test_any_bits_set(blk_bitmap, dpa / min_block_size,
> > > 			 len / min_block_size)) {
> > > 			 error_setg(errp, "duplicate or overlapped extents are detected");
> > > 
> > > 
> > > Fan
> > >   
> > 
> > 
> > 
> 
