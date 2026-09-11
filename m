Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC9249F131
	for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789144640; cv=none; b=YRmUXvRs/aRwbvYfYBJbCPotU84ZFkfAtucgKhUG2VzE9/4/ivp7qp5Dk5TztJItpZkccUtYWcAASgAjQ3tdkhDC7We1V4zye9lMC+l8Cr3renvdmAydoL3hj6HuA3HlLjSYkSdudpLi+hXyHZct4BKf9a69mXBMDM2HHk3PdDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789144640; c=relaxed/simple;
	bh=jQ6X7RG7jdaEWzOHLhejsMjiBOnpZMrA3DuWrqHtkAs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQsQeREQ6FM98ADgo7Vmyog/GVDYxHceWY7+x8lyxPzjU0MJ5zTH1BVCk0FgVgWoh6Wit95ZHdVqErFeXiQBiAyEeNLhIbUL2X1HkP46kk/25CYW38R3G4NWUyLVoXBuYUCz+NWGa3aAGlxKYTL3JdctlabueqxV5Hs3gQkJnHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r+8ijNYH; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+8ijNYH"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-86a31708876so952716b3a.2
        for <linux-cxl@vger.kernel.org>; Fri, 11 Sep 2026 09:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789144635; x=1789749435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xkma8la2NbYlXcHTVZy22IDEzY8IUBzs8PJv2U9UtuY=;
        b=r+8ijNYHsqcncoC2ttL2mzuj90DdCt0GxI9pI8pOV/h/KqA1YRiOB54Y+aRBX9kx+8
         hwKNFB/RrPvFNHynAzgTO/aIXsnZ7gSQXag2w/rykRcKZpfyAPJLQOicKl4X58zFCzPt
         8k7+WglaEvw8gbsi/yItVHCBQj3F7d48yqMGu7HNtTxquzzNEYCy6OqjjF1bfW5MMo2r
         A+ojyJCbgRx/oE43WMSZMFmSxHmCbLaJ5YyfC2dmkMBt3ygVzufGqT3XjkUuHbFvel71
         z23my1uNdexZQZWJ51n/QDr6tsh+AlphYBj0pk5zTgPmUF46W5jCo9PG1bj8L0bdJm6V
         16zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789144635; x=1789749435;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xkma8la2NbYlXcHTVZy22IDEzY8IUBzs8PJv2U9UtuY=;
        b=WfFRVsrDjbtobLuugPKgNxMQGWMY3P+4kEyN2X+4xf30CcvOjvHkl8gubhbqCOHKMO
         ZF5bbWVrgivWPNMTynL9KiQsOlZZ9Im87Codq70QOnB09ndFo9lmiSJROlzQtJw28EQl
         gqpP/tLFT7htHJTED+HJ5s56GQcTv/lfTP/FbB3GIxVXN3MraAD1kC2i3F0XsLJlMfi6
         JWVgF8q3N+6k3mlJWe3ppgPrZ60XSAWKbS+/2VLG7oSfHNd4boOxqt68enoZUt2zoVJW
         F+baDmiuq84jY+SWYbB/dGFqNwomlBk8evm68VRbGa9fTXWncfWnpTsVS7EeutYx+n+G
         V6nw==
X-Forwarded-Encrypted: i=1; AKwUvBwmq2jDIJj1c6UX8bwYjlklRAT1oAkrG8n1B0mp1xqA6jxIutzkAmeuqWTUCZr2tkJqIXB1m2cLgbQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nsq/82VN2DDfzT39a2Gh3yeo5ER9HxJHuTMwZdzgnmNt5barOe
	ASa1fcUYxg68vLgU8pW3UYtazG6ekyeZQycWeptxYEz1SMOPDbU08lyJhElRfpoo
X-Gm-Gg: AYBFou0uk/a4k8/83jZVatm/OQIS/6PP0cO0CqPr2Cs3NgKECS+2nYSJAnbWd0XNGPA
	w+HExDLnjh4DFifa0Ai3WHCenyvDGIlA6fiiKN+eUoKgJDjU9vwKSb6gneyHnToLTvhs0VsEovt
	WiNlbUELP1Ohi5qRQLNKuAwNSolXqJuCPJwDXRcKwAxTqnmpsuj6Z5f6l5ooLagAg87nmNn/llS
	RgOCROBDoM45HPWPuQFTf0xjLKFuJPb7Zbf1Ta6Pv4mF5sVbAE+BIa6j/ox3zYcQDJLkxIIORL3
	NUJw3fzoxTMpEIUhJUM+r+ML+ORHOivCcImZvwawHR6rCff7skozvtGOyPXDWD7y0f15pxBdCYX
	dSZOX2Fhw1owndxWbYUUxif08vIKlLyS2VxTnOlMT+jtuUsjIQhkYRo8EFmsgYTpoY43BDY7siS
	qN5sWF0BCgjt0xhFW1UTFq7N8x+N8bHz14z8eWxmmnk4+AWsDG11pQp1oCKoCcZoS59dqIkiXBJ
	CQLRdvEYVLumB/Ht6bEwlvIAg==
X-Received: by 2002:a05:6a00:1a10:b0:86b:43f6:67c4 with SMTP id d2e1a72fcca58-86b43f66c02mr6978451b3a.1.1789144635401;
        Fri, 11 Sep 2026 09:37:15 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b295baae7sm1373630b3a.35.2026.09.11.09.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 09:37:15 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Sat, 12 Sep 2026 01:38:31 +0900
To: Jonathan Cameron <jic23@kernel.org>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	alison.schofield@intel.com, dave.jiang@intel.com, gourry@gourry.net,
	icheng@nvidia.com, ming.li@zohomail.com, vishal.l.verma@intel.com,
	dave@stgolabs.net, benjamin.cheatham@amd.com,
	Ira Weiny <iweiny@kernel.org>, Wonjae Lee <wj28.lee@samsung.com>,
	Junhee Park <jh9934.park@samsung.com>,
	Heesoo Kim <habil.kim@samsung.com>
Subject: Re: [RESEND PATCH v13 2/8] cxl/mem: Read dynamic capacity
 configuration from the device
Message-ID: <aqQuh7zKKzBC63vn@cxlqual>
References: <20260908102124.2231730-2-anisa.su@samsung.com>
 <20260908102124.2231730-4-anisa.su@samsung.com>
 <20260908214310.2f9abccb@jic23-huawei>
 <aqNDoqRyMiTP3aNz@cxlqual>
 <20260911015348.6c45319f@jic23-hlaptop>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911015348.6c45319f@jic23-hlaptop>

On Fri, Sep 11, 2026 at 01:53:48AM +0100, Jonathan Cameron wrote:
> ...
> 
> > > > +	/* A DCD reports between 1 and 8 partitions */
> > > > +	if (dc_resp->avail_partition_count == 0 ||
> > > > +	    dc_resp->avail_partition_count > CXL_MAX_DC_PARTITIONS) {  
> > > 
> > > This strikes me as a compatibility issue waiting to happen.  Today the spec
> > > supports 8, but maybe in future it will support more and I'd not consider
> > > that a backwards compatibility break (which this would make it).  I'd clamp
> > > to CXL_MAX_DC_PARITIONS and maybe print with dev_info() if you see something
> > > bigger in the wild.
> > >   
> > I see... I did the below and moved it to the caller
> > cxl_dev_dc_identify() so the dev_err/dev_info messages are only printed
> > once, since the current function is called in a loop.
> > 
> > 		avail = dc_resp->avail_partition_count;
> > 		if (avail == 0) {
> > 			dev_err(dev, "Device reported no DC partitions\n");
> > 			return -EIO;
> > 		}
> > 
> > 		/* More than Linux handles is not a reason to refuse DCD */
> > 		if (avail > CXL_MAX_DC_PARTITIONS) {
> > 			dev_info(dev, "Device reported %u DC partitions, reading the first %u\n",
> > 				 avail, CXL_MAX_DC_PARTITIONS);
> > 			avail = CXL_MAX_DC_PARTITIONS;
> > 		}
> 
> Given you don't do anything with most of them I'd just do
> 
> 		avail = min(avail, CXL_MAX_DC_PARTITIONS);
> 
> and not print anything.
> 
> Thanks,
> 
> Jonathan

Makes sense. Done.

Thanks,
Anisa
