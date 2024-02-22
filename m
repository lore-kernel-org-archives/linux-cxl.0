Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE1B154C12
	for <linux-cxl@vger.kernel.org>; Thu, 22 Feb 2024 16:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620970; cv=none; b=Sk1+LcL9Ftgtit7omVITm4prxRRgEXrQakJ1P++kLJLWeggT8ipcZphTQWIefM09PMbww0KYTqOXQfY4PblvTi8bQ/rIR9a2cokyH7z0hv8NnjZK/24/sWlf3MENKgHzGCSmsmOi8DLrSJ6ekGzcTpQb/cFZl4u6/+ZRhGG4zjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620970; c=relaxed/simple;
	bh=/GST2RKhooU54cpe4RLP2jvd8Ytv771GbeeZiuLCD+U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSO6oAydMdefRLo+brl8xBBfti9aCO2iDJ2iwtxigcupKSDwyKlVAD9Xv/UGcoBQissN/lqMrxfaPOe3VMgqqQZlTxCiVEL8RCRfA8o2VQp/cTIjruLdIXDtvJtElt0h+xH6QBfUfNLvwUXAwrn7J5XRsLFTwQiH84acaiII31o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=As0bq3Qj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="As0bq3Qj"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e45bd5014dso2255342b3a.1
        for <linux-cxl@vger.kernel.org>; Thu, 22 Feb 2024 08:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708620968; x=1709225768; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YPbA6TpI1b5Y1eRi4qIE3WJTJORdzGj63jllScn37vE=;
        b=As0bq3Qjm1r3wrvqk22vlBF28OA/MuwmIJhz311Iuty+Xn5lMsEYKxN96sRtzMFuhU
         +YVhx/WsZHoNa9OmWtQjDIak68apRCj4YiK2ZORxL8ptYruc5b34L8ySgf1PhdKoCc9V
         +E5l6cocDZE7yqx7cqRtZOn901VXlDxFlvT/F6/tG5EKbfipUY+fP6AcjJqd3eMFq1Rv
         DiiKG4MTUs8sd161yJWdMVurHt2sCnTpQY3L2+XCpW2kIlfwFW4r8k+ZZ6cG9iTTyAjz
         UlhN374+TXCVyW++uyTV9DPnIKAD4JisGRic/VBrTUfs3gnSYiHDJmwaidkT6wNzFlb0
         eBEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708620968; x=1709225768;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YPbA6TpI1b5Y1eRi4qIE3WJTJORdzGj63jllScn37vE=;
        b=TBXPeYqdSpygqzAE7KhPBHZuWwYreG/8ly/kHM6QAWn4zFiZbv6oP2L4gvQLnKQZBe
         ApfKOvBoII5NniRrKvTBbMllQav4ILkz5EM41Mcm1A+ZUevJK6PtbCUXkRBmWdVq3ZE3
         YmP7CY0lBAtpSQBx9U+jGC10X1XUML2leH1yxnUzL+6VgJUbrGjsUhiaq3nVlPdJNWjA
         CX7+bDbhDBMfmnqCobyrdeRmRAz4Xyip0FP5tF6Yh+/cYf5zRi2Wu8hK2cRI1hjglRVo
         D5v6aXaviHHAn6do7RAHiZYM/nsebIHrk20vUNA7V0eJDv/o1GquJC7vgr+JgqdAEb+u
         2OzA==
X-Forwarded-Encrypted: i=1; AJvYcCWhtFC9pclsTRThAqatx2dnfidaYjTtkwMPYUbsFN9VFmRLz5NlUIeEDKtYHtPm6fZJ2wcUBDxJaA13GMl5f8NQBudovXoXHDup
X-Gm-Message-State: AOJu0YwqwNH1iYPKdkTGtG2QWqpRRp4Dk12mkmpWpNbTTerxqItIypw0
	ShONKJoac0HjYRLwiPs75seWhNJarvBIgWJ5g64Prt/806RPmZOY
X-Google-Smtp-Source: AGHT+IEv7YEBfHb3hssf0AOzxXGHxCT8otNmE4GpADhY5zDL7NEkPiFEJ5yzs7z4H0LKY7sMxrxNSg==
X-Received: by 2002:a62:e10d:0:b0:6e2:9ff2:19b1 with SMTP id q13-20020a62e10d000000b006e29ff219b1mr13800579pfh.13.1708620967919;
        Thu, 22 Feb 2024 08:56:07 -0800 (PST)
Received: from debian ([2601:641:300:14de:f32d:6b5:d03a:44f])
        by smtp.gmail.com with ESMTPSA id a6-20020aa780c6000000b006e04ca18c2bsm11159868pfn.196.2024.02.22.08.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 08:56:07 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 22 Feb 2024 08:56:04 -0800
To: Wonjae Lee <wj28.lee@samsung.com>
Cc: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"gregory.price@memverge.com" <gregory.price@memverge.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	Adam Manzanares <a.manzanares@samsung.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	"nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
	Jim Harris <jim.harris@samsung.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v4 06/10] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Message-ID: <Zdd8pHzj38BsJwsL@debian>
References: <20240221182020.1086096-7-nifan.cxl@gmail.com>
 <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <CGME20240221182137epcas2p276d22514caaa9412d0119ded6f9a63d4@epcms2p3>
 <20240222092252epcms2p389f3b87b6ee63cf6a0e95aaf8968970d@epcms2p3>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240222092252epcms2p389f3b87b6ee63cf6a0e95aaf8968970d@epcms2p3>

On Thu, Feb 22, 2024 at 06:22:52PM +0900, Wonjae Lee wrote:
> On Wed, Feb 21, 2024 at 10:15:59AM -0800, nifan.cxl@gmail.com wrote:
> > From: Fan Ni <fan.ni@samsung.com>
> >
> > Add (file/memory backed) host backend, all the dynamic capacity regions
> > will share a single, large enough host backend. Set up address space for
> > DC regions to support read/write operations to dynamic capacity for DCD.
> >
> > With the change, following supports are added:
> > 1. Add a new property to type3 device "volatile-dc-memdev" to point to host
> >    memory backend for dynamic capacity. Currently, all dc regions share one
> >    one host backend.
> 
> Hello, I know that it's too minor comment, but 'one' was used twice.
Good catch. Thanks.

Fan
> 
> Thanks,
> Wonjae
