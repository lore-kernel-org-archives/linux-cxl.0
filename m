Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7C154B1C0
	for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112187; cv=none; b=kyvdeduuz8qmM6E/uws4cDel6n3tRFPPiL3fg6s+IYcRmaon7L4RHXkZflLtJpXA4TFLWPaje/Pedz4vaaQbWU5LMUxsbDEn1psv+nT0UE7w7BphE9Chsv6mwPelnqp673EY2vjOtvxwcEKrALOOafLs1JAe7LfDzTpkpY+RV1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112187; c=relaxed/simple;
	bh=K2iy4Ay07L+CLr1R6FR8IKCbYgYrLG1K+Zr8MvmRZP8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eu0Lfcu+lY8FvY2MTlIpipPww7Tp33oOAs6p4C0iBnirs/p7cDPwQHe+WQGDxhMg31K21aHumZ/Pb8VREYSysxxrWTtxZISndXaP5f+tm6mh7feIyYGOP+dYsxIvlG01lkW4ycRMgaTbPWCyGCjjzexTBJ15+ueGoKL7v1cf3Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCHwjuEe; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCHwjuEe"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-85d46e4cdccso4489297b3.1
        for <linux-cxl@vger.kernel.org>; Tue, 22 Sep 2026 14:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790112171; x=1790716971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AW6wgUqZie3+2nEFNr3AH3xe+NG+9YZyAQ2E+Gvd3kI=;
        b=BCHwjuEezW31NdJOUj/eioKM7qO6hXgGvpXcuAJ5kmOl7HI/79d+fdNCli84TO4CXj
         jLnoNzCSfpTE1Ld221HtXepQA+qmy0D5zy4rc/YTqqZtD52FPaisNl/gmwsb0X1VnM6x
         v+W1u6oXXjxKymGV0EtRN9wWr5D0S4Xp46DuWXo3qxOWCRj/dJ2ETelxKHbw3+JKeNvM
         1cf1+opTPbgD2l/XiJmk/7j0j75ME5XH8eR+0fu1QT9X3EI/t0u/w4XaP5MBI0H7Inkf
         yaZJc2/DSJ5IH6Q2HJ5+oaY15qElUYiV69l5nXY7DT2KYsaMjxeAP46zaFs7gIju+0Iu
         gZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790112171; x=1790716971;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AW6wgUqZie3+2nEFNr3AH3xe+NG+9YZyAQ2E+Gvd3kI=;
        b=roGsb2YNGxzce/tUHDBX76cauAmYGF2xJqxMwLU3kCuFNsngcg6c8a9MImllxEtZun
         AymNGHgBJPlDa5u9lcP4DrBc+Bgz8Yeyb3rcDvDsBY2SWkM0UCLe8Oly+Bh3GZka2zlo
         kPmCq6WC65/fLwCYwkNRbKPx7N3ST2rHkv8JwPVnBClNGBNZ3PWglafqS1FixuK4Xr+a
         k5lICmlRgXBg4XskRaSed/t6i3XqAZBBgZFtf+3z1MnytfYRxazEuPiKZVO9KYyicHL0
         R/+eOU4HUGR3kBaTG3IDvYrwg3TeqaiDuSzbzBeiZbshBajm0M2v1btVvMRxUN+urf8O
         YY+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwanLQ18INx+iH60B1R2sYXETzhHcV1tktmjKzhw0cPYej3Nhk0HRvnXZsvVkF2j/8t1cQV4PnNv2g=@vger.kernel.org
X-Gm-Message-State: AFuF++niXFe2XXO1C0xlEbdOrTryxrWxwpaXg46ePGLLd63rRrwJj0HT
	7pBGDIwYLQS22/jvTmjCtzs/QrENyDL6ZWR7LVlV52nd5SLnMagtbf8T
X-Gm-Gg: AYBFou3FImqofE1GxyT4c+tgr7JtQg5/VX97ygoaZloB9fXLswtDRDUsVgmQvRQNpJt
	yQRfHIrJYiq6R3tXy8AsMFIRtaV7q7KXbrtoDfrAJXRNFPDCUJDUm7gkC8969o+FsTghrNp0t30
	dEwuyFS+XaSwZ9zlgozL8iIEQc3khTETXR8RfOToc6JnOFeFa2D1ugpiMSTyxd0sTWfK+xasDxQ
	SvpfUkwE9PTCNEfdBOOaPbHgoTV7m/Ev/h7N5Uv6FBSQx4GTJEtTRUCeESGK4GBE+L3sD08UEYV
	410ZGDHWXjIT2gGcBCVwzmvYc5hXOW3gy/WQeY97MiB4UIHR+gmOjjiPBbILrPQ08EKjJFU8n0d
	QOcxVRaCHHpmvSMVOp6vNwZSv3OOkeh9UllvZX72EIp1eZPjnK/GEaTRRmFvEo5GuH3SAtU/RTF
	avsivUvF8fGJj8xl5Myph3Gh7gpYKLxglJr1KWmgHjWnQkT1sDVA1Ueoa6DgvMsMMjqt5ktfWlI
	O4KXFeIOCaZ7ZSXEU7bLfE5KP6kPXzzzMm1h/xQDF7Q281VVjVr1gRLFnNr
X-Received: by 2002:a05:690c:c757:b0:89b:689d:3a74 with SMTP id 00721157ae682-8a45b19695fmr4521277b3.43.1790112170533;
        Tue, 22 Sep 2026 14:22:50 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a4658c9778sm2614357b3.8.2026.09.22.14.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 14:22:50 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Tue, 22 Sep 2026 14:22:47 -0700
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Anisa Su <anisa.su887@gmail.com>,
	linux-cxl@vger.kernel.org,
	Alison Schofield <alison.schofield@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Li Ming <ming.li@zohomail.com>,
	Gregory Price <gourry@gourry.net>,
	Richard Cheng <icheng@nvidia.com>,
	Ben Cheatham <benjamin.cheatham@amd.com>,
	Ira Weiny <iweiny@kernel.org>, Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [PATCH v14 6/8] cxl/mem: Configure dynamic capacity interrupts
Message-ID: <arLxp9mx-IPNCPQq@4470NRD-ASU.ssi.samsung.com>
References: <20260918203049.7273-1-anisa.su@samsung.com>
 <20260918203049.7273-7-anisa.su@samsung.com>
 <da6deab0-de16-43ea-bd13-5861f84a587b@intel.com>
 <20260922004228.5a0c027b@jic23-hlaptop>
 <a26d002f-1dcf-4bf4-bfd5-dd587c559029@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a26d002f-1dcf-4bf4-bfd5-dd587c559029@intel.com>

On Mon, Sep 21, 2026 at 05:45:56PM -0700, Dave Jiang wrote:
> 
> 
> On 9/21/26 4:42 PM, Jonathan Cameron wrote:
> > 
> >>> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> >>> index 7b756000a1a6..6ef47265da10 100644
> >>> --- a/tools/testing/cxl/test/mem.c
> >>> +++ b/tools/testing/cxl/test/mem.c
> >>> @@ -1818,7 +1818,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
> >>>  	if (rc)
> >>>  		dev_dbg(dev, "No CXL FWCTL setup\n");
> >>>  
> >>> -	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
> >>> +	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_INFO |
> >>> +				       CXLDEV_EVENT_STATUS_WARN |
> >>> +				       CXLDEV_EVENT_STATUS_FAIL |
> >>> +				       CXLDEV_EVENT_STATUS_FATAL);  
> >>
> >> Second time I'm seeing this constructed mask being used in this commit. Maybe create a define for it?
> >>
> >> s/CXLDEV_EVENT_STATUS_ALL/CXLDEV_EVENT_STATUS_BASE/ perhaps?
> > 
> > That was Anisa acting on my feedbakc on previous.
> > I don't like _ALL because we already have an example of the spec
> > expanding and the definition becoming messy. But mainly I was
> > pushing back against _ALL + masking with one element we didn't
> > want as fragile.  So I'm not against _ALL if it is made up of
> > another define + DCD (for now) and that other define can be
> > used in places like this.
> > 
> > Bikeshed time... BASE is usually a define for a reg address and it is
> > is hard to come up with a name for that when it is a mixture of
> > RAS stuff and INFO which can be a wide range of random nasty
> > and nice things.
> > 
> > So with the right name seems fine to have what Dave suggests.
> > I'm just not sure what that name is!  Hence I'd just stick
> > to the long hand option.
> 
> Yeah if we can't come up with anything good then leave it as is. 
> 
CXLDEV_EVENT_STATUS_STANDARD_LOGS...? And just add a comment kind of explaining
what "standard" means:

/* Logs whose ownership follows native_cxl_error; the DCD log is always OS owned */
#define CXLDEV_EVENT_STATUS_STANDARD_LOGS	(CXLDEV_EVENT_STATUS_INFO | \
						 CXLDEV_EVENT_STATUS_WARN | \
						 CXLDEV_EVENT_STATUS_FAIL | \
						 CXLDEV_EVENT_STATUS_FATAL)

That's all I can come up with.

- Anisa
> > 
> > Jonathan
> > 
> >>
> >>>  	cxl_mock_test_feat_init(mdata);
> >>>  
> >>>  	return 0;  
> >>
> >>
> > 
> 
