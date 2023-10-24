Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58F8219ED
	for <linux-cxl@vger.kernel.org>; Tue, 24 Oct 2023 18:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOOwAkxc"
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CE3D7D
	for <linux-cxl@vger.kernel.org>; Tue, 24 Oct 2023 11:56:25 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-5a7d9d357faso48649387b3.0
        for <linux-cxl@vger.kernel.org>; Tue, 24 Oct 2023 11:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698173784; x=1698778584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UBXl9Zj719hVGlSSrNcnrS3aFPeT4AGbDU2dqyIe3/w=;
        b=iOOwAkxckvKipk5vMokovs93JDfaMgaPTwz+1KhaujCdEneDObft2b4ONrooURnqBZ
         wxGPZxi9iUPJttVjtJE8vc5X1WSVZCSUW+sE2UX1U8KXzEhnhzZdmJrMg2vwJENCj4Hg
         Nkl7dloekEz1t92long2+JSHoyISaYE+RBP6GBdGC1q7WxW48BWITCknCvDBaDvB/0zU
         DzD7aHQarpimzArYqpRCCeDwP7sIKdMwtT2PvEeNddpbnTVIyK4OZFdDStPa7xd4zHWJ
         NxrMcS7R5+MQHdbSPbn0oZy9M8+Yqv8+MdEfdXxfbXGM3fPvIB4ro5iDy2bfihSxNyy4
         1Pbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698173784; x=1698778584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBXl9Zj719hVGlSSrNcnrS3aFPeT4AGbDU2dqyIe3/w=;
        b=NtHoZigduMy6DwMsv4h9bh9YQ0/8WaP0cSKWuYSS69Jh9udhX7SMZEsdcSKaFkLIj5
         LOtOmbSQXwkvZ580Kjsbl65MimETYGzavORr+5NSDl7Fscw4uS4QmAC1uwQN20AZjNec
         Rdyxw8zhQK246ZyxhrRl5V/47+zJvmMc4dJEunt45PEDU46wKxMx/IjlkH91pu4ouVWh
         s3Yp38pYLQ+qZTqyP06XuZK2t9r9XHykT4ZexrIOgFC91syCVYB9Ys31ak+mgrw8zVMA
         apoiOXI3S9M/YRdb2Z+zr8Cykk2sY3gf0cyIZE1ApU7mbenpiftT+FNIREW27jvniunV
         UxNQ==
X-Gm-Message-State: AOJu0YwNEVZy/5T8q9XW1VQbX6+oRmGBvAF0BEhh4z+wETLT2SMR2xie
	xrPoK1hmUc+DffvWz+z+wjg=
X-Google-Smtp-Source: AGHT+IGR5pgBZC173P/hQrkxSG1QL0wlCxKdFBiByrK+4AaluigkyyWuLfDIye12ZOXpjnBgnL5SMA==
X-Received: by 2002:a0d:ea8d:0:b0:5a7:a989:b85c with SMTP id t135-20020a0dea8d000000b005a7a989b85cmr13696578ywe.16.1698173784303;
        Tue, 24 Oct 2023 11:56:24 -0700 (PDT)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id t22-20020a0dea16000000b0059b1f6d1959sm4266801ywe.101.2023.10.24.11.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 11:56:24 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 24 Oct 2023 11:56:02 -0700
To: fan <nifan.cxl@gmail.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	"Singh, Naveen" <naveen.c.singh@intel.com>,
	linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com
Subject: Re: Questions about the qemu DCD support in cxl-2023-09-13
Message-ID: <ZTgTQs_HJ9Xlb0Ov@debian>
References: <650cc29ab3f64_50d07294e7@iweiny-mobl.notmuch>
 <ZTbN8mAa256JWTFE@debian>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTbN8mAa256JWTFE@debian>

On Mon, Oct 23, 2023 at 12:48:02PM -0700, fan wrote:
> On Thu, Sep 21, 2023 at 03:24:26PM -0700, Ira Weiny wrote:
> > Fan,
> > 
> > I'm working off of Jonathan's latest CXL branch with the DCD patches.[1]
> > 
> > I've been testing various things and so far I have a couple of questions.
> > 
> > 1) If the qmp command is used to add extents which overlap other extents
> >    shouldn't that throw an error?  I don't see any validation of this and
> >    I would think a real device would reject such a request from the FM.
> > 
> > 2) Where is CXLType3Dev->dc.total_extent_count set?  Attempting to add
> >    extents prior to driver load does not seem to work.  And I think this
> >    is because total_extent_count is 0 in cmd_dcd_get_dyn_cap_ext_list().
> > 
> > Ira
> > 
> > [1] https://gitlab.com/jic23/qemu/-/tree/cxl-2023-09-13
> 
> Hi Ira,
> FYI. I have updated the DCD emulation patch series based on feedbacks on
> the previous version.
> 
> The new version is here:
> https://github.com/moking/qemu-jic-clone/tree/dcd-dev
> 
> The code is based on Jonathan's branch cxl-2023-09-26.
> 
> The main changes include,
> 
> 1. Update cxl_find_dc_region to detect the case the range of
> the extent cross multiple DC regions.
> 2. Add comments to explain the checks performed in function
> cxl_detect_malformed_extent_list. (Jonathan)
> 3. Minimize the checks in cmd_dcd_add_dyn_cap_rsp.(Jonathan)
> 4. Update total_extent_count in add/release dynamic capacity response function.
> (Ira and Jorgen Hansen).
> 5. Fix the logic issue in test_bits and renamed it to
> test_any_bits_set to clear its function.
> 6. Add pending extent list for add/release extent event.
> 7. When add/release extent response is received, use the pending list to
> verify the extents are valid.
> 8. Add test_any_bits_set and cxl_insert_extent_to_extent_list declaration to
> cxl_device.h so it can be used in different files.
> 9. Updated ct3d_qmp_cxl_event_log_enc to include dynamic capacity event log type.
> 10. Extract the functionality to delete extent from extent list to a helper
> function.
> 11. Move the update of the bitmap which reflects which blocks are backed with
> dc extents from the moment when a dc extent is offered to the moment when it
> is accepted from the host.
> 
> I was able to test the DCD code you sent previously, let me know if you
> find any issues.
> 
> Fan

FYI. 

Updated the last two commits to drop the extents for pending to
release as the host can proactively release dc extents so there can be
no pending-to-release extent list on the device side.

Fan
