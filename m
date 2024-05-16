Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4874A4A3D
	for <linux-cxl@vger.kernel.org>; Thu, 16 May 2024 17:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715879240; cv=none; b=UwnfDeoeXbKvsHjxRix8I+UOt27dFbkeQOM0g+Xi4Sgv5V+lqchRqWSLGK3XsepsVJLXNWU07egrPDx7kUfmYyLNVEnRopPj1lPM+LHYfRPfUEn7d/l0AjjFCMi2VX35ykS4eUF7P8Oc8tCgMjyUlydQ7DvJdoSpe6Q2twBOxbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715879240; c=relaxed/simple;
	bh=IaRZls+QvIbxKHEYeKai4T2tCoXYZeLIpaZ2otECCKI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=izCD4JSeqG3zS/KROIZRddvDVc3LULFczO9dGZKKs3vlaIP+oGAwqffbuJZiVj8PlLuZW03kmhcTPiirWjhQ+qF7xD45k6XkKLEci0DmCZFb6p2pC0bdGNNEi8WqW13VsW9zofP35evkorhCW5R/8SMP0627trs3riGgNnTxhZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MOvw9Nxb; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOvw9Nxb"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61d35d266e7so99022297b3.1
        for <linux-cxl@vger.kernel.org>; Thu, 16 May 2024 10:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715879238; x=1716484038; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+lE/fdqdED5PMDQDplU6RjaHfk9UlWaLcBCTgah5zx4=;
        b=MOvw9NxbWI5rYhk/4A7OCNh3U1K5h0zHVoF/tkKyYkgjJQmABDmLpPDMs1QVpsLiSA
         AxhBj3R2QpSfD2eVdqo1L/y0K64kDpNXjXjDE9GAXoUhuxo2XJHTj2mw7M80ej2VmwwF
         6CLhyZxSkU4H7aDDLKTOAgMAOYRLxjk2gFv60Vc5XNezlE7CCzms3S1dtkhBdOnaTJAV
         K2R3y9OD6iCmVe3S60IEKAfyS4JSxzyzXTysRA/he4elwEZaD7t5XsciiQOBeJBuckrv
         9bMnFJRoJ7NqQEhZTPvQ9YxIRant+TD8UgQW4TkLP7n5/NgsSqPaSXbmDgJSENZ+O7Hj
         dqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715879238; x=1716484038;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lE/fdqdED5PMDQDplU6RjaHfk9UlWaLcBCTgah5zx4=;
        b=YL75DA92Lfo5Ja9ZQ1OsGHANOT0eiRSFNtx4de7nzO6FH51gOCMID50nerN35QUQNo
         UjKONReBeP6E5p8cb86SCAg37k05Z59BrHjbqb1eO+3uJ9bBG1z5X9bbe47EWpYsEP5c
         srR0CZ9Ftx84R2d2fM6Y3NhfuHOOKIPrQbXY1Fj+hxfN1jmlQ8gLRZ+TM+eJugvFw54r
         z7QeU+hNzwW/PcV3Zqr1aYmhxxZJJbplJx5R844s4SyPTzOvsM+da1g+egoM5fKaBjTe
         N6pikft1Qvl9fxKobsLD0IfRGuZaFkX5yD3TtzUSyZkHZt3GpgKxNFZaFkZR29xEDrD5
         TNww==
X-Forwarded-Encrypted: i=1; AJvYcCXA5IRdQCVY/JfMYJBHVagHcb9rbW38T4ig2Ldfx+eSu7Jd32RIIQ6bWlJiS1rfD+spdT0SJzaTAw3DMuMH4gAzfGkbAsoEr4Zi
X-Gm-Message-State: AOJu0YySgXJ3gSVhEzq97awag5kEvd+GJK7oSMNDwlmT4WLntdlG26YU
	RocEmtcnLFaQqKxW8cp6I9hj1KZCncjnusPHv3GY2UOzt0+yUXdf
X-Google-Smtp-Source: AGHT+IE3+KlENGt6B2v4Rw832ZQSDvm65azim0pMGuIbAXPfy2fzGSc+JyiQRbQMcYkcP8SqLFVEPg==
X-Received: by 2002:a05:690c:ed4:b0:61b:1be9:bbcb with SMTP id 00721157ae682-622bce53727mr188168727b3.44.1715879238279;
        Thu, 16 May 2024 10:07:18 -0700 (PDT)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6209e257fe2sm35690697b3.45.2024.05.16.10.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:07:17 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 16 May 2024 10:07:15 -0700
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"gregory.price@memverge.com" <gregory.price@memverge.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"a.manzanares@samsung.com" <a.manzanares@samsung.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>,
	"nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>,
	"Jorgen.Hansen@wdc.com" <Jorgen.Hansen@wdc.com>,
	"wj28.lee@gmail.com" <wj28.lee@gmail.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v7 06/12] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Message-ID: <ZkY9Qw3sSYeke4n8@debian>
References: <20240418232902.583744-1-fan.ni@samsung.com>
 <20240418232902.583744-7-fan.ni@samsung.com>
 <6221399d-5fa0-462b-ab55-47a9f664fddd@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6221399d-5fa0-462b-ab55-47a9f664fddd@fujitsu.com>

On Tue, May 14, 2024 at 08:28:27AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> 
> On 19/04/2024 07:10, nifan.cxl@gmail.com wrote:
> > +    uint64_t dc_size;
> > +
> > +    mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> > +    dc_size = memory_region_size(mr);
> > +    region_len = DIV_ROUND_UP(dc_size, ct3d->dc.num_regions);
> > +
> > +    if (dc_size % (ct3d->dc.num_regions * CXL_CAPACITY_MULTIPLIER) != 0) {
> > +        error_setg(errp, "host backend size must be multiples of region len");
> 
> I prefer to have the %region_len% in the error message as well so that i can update the
> backend file accordingly.

Will add.

Fan
> 
> 
> 
> > +        return false;
> > +    }
