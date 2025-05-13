Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FF92BE0FD
	for <linux-cxl@vger.kernel.org>; Tue, 13 May 2025 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747151404; cv=none; b=JARKNl6eJL9ztXawjY3tVezVz4OZEBFOqYqnJhFzQlv9TeWelOfimlXI6Z3VCgg93Ki6ZRWkX4A+Vl6K8X+hEZpFCD/EKLnqauGEGL22tOPvBLHijL5NvebnixKmXE5CTa+WgS+fnDnwtnuE17L057J684MBs23GuLNuEmcF6bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747151404; c=relaxed/simple;
	bh=LWlipWXvgvhKKarucjjMr8cGI4+DAl6zPWOqCUJdZPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrbM9NU2PYqjBn3cpOL5pqQlbfSDmqvnzLFxlZN1AI88qy7PJ5xsTbnF5jlB1p2LHfWsDczAo6Jc9x++S2vKylNA7M/iJuK3/QFMsfPYvYi9TtO6AGKCdJWpjnqKJtmGhHSxcjta+WF2GAYRUmIVAFnY+GQ/DEtHlixRlcGO0Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=eyYSs2D7; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="eyYSs2D7"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7caeeef95d4so625038585a.2
        for <linux-cxl@vger.kernel.org>; Tue, 13 May 2025 08:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1747151402; x=1747756202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LWQzs9vOS8qvYu4GiNC5TtKp84D1/3NfIsOIrEUWWhI=;
        b=eyYSs2D7MPSvwfiZF8xHZnZLm7IJsBDrq8OJDXw9XqvlynvHyIWDD4+7+cMZjw4Pa0
         NWnoZskFpH+8qbp6kjDpN7ggUONJTjJyTxqGt7+E0TC4BDYqUFKkbJ/yg1RZ09rnE1nJ
         2R9O5BV9NLgA5TiGpMZbvjYOUhlX/4bf54h0qSpnuMBNUBwESeahm7OT/QLAi55+6AZz
         iX6S3IMUCp62BGbRgAfSyVEueo++VeEbKpaIbYmyuh5BqgXvKUIMypgqNaktiL8ynTEj
         oQoTl02VuNR2koR69cs/rUPB5Ip85tnLkCjrsej+prfSW5W6NDXxAsAVO4WTfgIxWZI1
         7s/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747151402; x=1747756202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWQzs9vOS8qvYu4GiNC5TtKp84D1/3NfIsOIrEUWWhI=;
        b=HFAEMJeitzcGHfQYYTeWtSATBTKSNrMiKoF2yMNTgauOqXFXD8UBI3HyXxRD4RsnuZ
         ZLxRLFH53rVSv+BmdydAykdWTesJiHeTD391yMDs69CyCIa4UtoFBuF2gdC9SvNBHX2c
         7OwXAHQe1pzUxhr2LnEmwFj6E4F8QcZXsa4dH0PtmVAyTehJuPfP9F5HsKhE9f54Lb8c
         r8DMQfxy+jEBMwNePxpJgHEKq8V0pO0nWeRHbH4dE8+4d9Ams/iUnGoYG4UhNTJKY7Xh
         1gMJQMAQM3FTyetA/mLSSwqj9YU4Nb/3xjLAacJcdikSlQpWEU6aXVvCKk9ZeW6D9a0G
         s3Sg==
X-Gm-Message-State: AOJu0Yw+n0HA1Dm93XP1z0vOqGaKLxOKhdbsZ7qj1rMGVus0Fur9Ox04
	Ugb7coddyOctVBcLyXLy2f2HGNeMYlsLokj1/qa/58xVAVLkhx5AXQXeVDxsN5s=
X-Gm-Gg: ASbGncvnzNIYg8BAMa+4nakkvnE5EEwJ12naJHAquLovK7oAzj3yImtgHZx5A3q4xgD
	izryW3dtZ5BXTH4FxeUe1EOR64mN4WNTYJiGlDrguuO8GNXM9dXH03EPc33ED4AcAdYbYlRP89K
	Ixhb1C7rKyZAvtpZ+ZoQ6YLm+pIVL8Cpj8aiqdtjwigl4rH2izNrPCGGdPBrgBQDulWpOj5FGjf
	rPfxGE0+wolp1U3x0twGnjOqdh3jsYraAeC8JMIUIY2IDXPPUhSLsD4LQfRVsB3Qh+R5GjIu5Ey
	D4TVT+Hmn94S+9tZVfEhmlW9Iwdv7jhUc/9Ri8jUyxesIilRTqYRWYxzqPeQiUlMEJEHI67JZJV
	K1dzzdCqJSC9UrZfZmON7r0WFcU7euxY=
X-Google-Smtp-Source: AGHT+IG7xhRDG/qQ/b1Z30HMCV6L0/wMmUWWXxdWkS4y+qdNZGo4jSp+faXrec8zWGdgnwJfvpi5CA==
X-Received: by 2002:a05:620a:2985:b0:7c7:97ff:ca42 with SMTP id af79cd13be357-7cd28856392mr5961785a.41.1747151401814;
        Tue, 13 May 2025 08:50:01 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7cd00f4e172sm714003385a.15.2025.05.13.08.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 08:50:01 -0700 (PDT)
Date: Tue, 13 May 2025 11:49:59 -0400
From: Gregory Price <gourry@gourry.net>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, ira.weiny@intel.com, rrichter@amd.com,
	ming.li@zohomail.com
Subject: Re: [PATCH v2 08/10] cxl: Add helper to detect top of CXL device
 topology
Message-ID: <aCNqJ5JI2_U7zh-Z@gourry-fedora-PF4VCD3F>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-9-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507004310.3536991-9-dave.jiang@intel.com>

On Tue, May 06, 2025 at 05:43:08PM -0700, Dave Jiang wrote:
> Add a helper to replace the open code detection of CXL device hierarchy
> root. The helper will be used for delayed hostbridge port creation later
> on.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

ignorant terminology question: what's the different between the
"cxl hierarchy head" and "cxl root"?

~Gregory

