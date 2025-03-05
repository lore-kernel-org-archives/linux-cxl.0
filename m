Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC6424EA9D
	for <linux-cxl@vger.kernel.org>; Wed,  5 Mar 2025 15:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741187308; cv=none; b=daCkpAPaVbXkROumoBzET1RzR6coPOJNl5n3IGjd6/3BXTvA/mJkpBrcWYIcpQGVhJC25Atcx3w6l5/PufKWvM3lnF/6SiSRu5sRVX0iD61VhyhZxJrtX0eT9fjVN8x+L8OPJnb+aDrg3oZJ3APS+2cD5puElVmUkBElrQpCZYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741187308; c=relaxed/simple;
	bh=qkk7BM6Tlh3hTIoRZk5iaAXN3AkN+GK8WjOtyMbuJ1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVHmBidpb/l5VXu8YyZMC+/PdyUsIftcDcXmGA5wi49pR7owmp8zOVeDm8gwDeSpMLQpP4my6S5gPr6MQrFDzDhlGQf6d0oyJQl5Zkpa5UwMJr/yFK5v98lkPBwYKjU6kh4hREst8Dq1/peoekDKm4UVt7XnhZW+SXuyxxATn7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=BZMDGDG2; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="BZMDGDG2"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so45519815e9.3
        for <linux-cxl@vger.kernel.org>; Wed, 05 Mar 2025 07:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1741187304; x=1741792104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gdvXoLdUnuAJXkhm7GFBvnQ72ne3nL0Mv6leNbRadPA=;
        b=BZMDGDG22SgwNokwc78rztg4mN2Gh+yS6eUqWzvqIaqpoa6AqlcPIzgjELrehP8jjt
         A8u8ywQpCjN57FvixqII1W1/jEEb0+44mesGKtcB/vND5ENgyqFJrE3iHUU/P3ySXi2i
         o60pqFMOuUQufOGsdJHNvP0lVBbdDhjmMhWqWLxahBodefdv1YKmAuNQEV3fAbHf5UeE
         DyEOzenLPXMamb8yxhL8XS1UrK35TX1HwN038vkKN+9ZoTTWE0hTFhlgf65iymEDsqsR
         fJGbOFAEfIJ4TiKy39tKqE1XYgcWJI7XnVSeprfNo/AorFjYmMzYRxhRVgQkS/+9PG7r
         /dwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741187304; x=1741792104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gdvXoLdUnuAJXkhm7GFBvnQ72ne3nL0Mv6leNbRadPA=;
        b=pCNhHqzMPY79pnfnEGFjqQAtaNqx8v4+Tvbe7QlCYCBJbY3oqGwEd76tgZrZXeZacw
         OuMRpYvgzMNNWcZ4kqg0I6uls3mBTTw8c4SzUqo3XvNlcTePpvCU0cnl9zmwCLr79Lc6
         B/+neQ51OIYQRC5Hc0S8TkeO2XFjEOn+j+NENgY+caTDwBXKQfj3o8BnbShtd2jYkrvS
         E3TGS/Z2c+NKog+I8xH+gArpLPU2ocwsyRjbhw49qy7wMC9M6MCMYS8pP/m4ygcSvLsv
         +p3iB7Rr4WmImjoGe0TxdUWaxVzveINDyvBaZmENpZEgAvSLo00dYBYSMilqbbeId0yO
         E2ng==
X-Forwarded-Encrypted: i=1; AJvYcCVFcMtwOa2DdyoKY7FLtSg6Fco/1XAPhbfbxRjHtXiue0i51dAU9/zTufEMFgVBzIVD8hvQdhXqVx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb1ihIH4V4BG5eGSHJyQkBHpgjQiXCua9aHtO9LRh/t1VCDtB3
	a+LfWyjpBD8acOGgw8pgIsQ/OXC6PG1HLkZJ2pzRClZkSh7nfGOyd2jOcVkmvFA=
X-Gm-Gg: ASbGncu1EfcM8y0PwNAPe3YZTQkmfsNZnLMemz55QSMX8dd7H9ssJ4VV8Ho9tgG8KTr
	WjT+sEJrr1Jz//+A9vE6/n8RNYbSPLzOTDi+j3IDox9zQQ7IQNw36pdWcDIkfbEcHyaYEbPe+Iy
	qmhLHpjBMoU0PfQF9xFkAUEX1VKzTr7fAsCYtGwJRPpqJ761bru/F5cFOs6bFOSgmVmNI+opBRz
	lmB9i2zK3lOUxHrwUpzfeJOxkwvPuPDJ8xCuA4uXYITDiOx/s0ze/s7EUMSxaMKnNXloe5aDtb1
	6pjXx7orO0677aBSzFKWWQ8Q5gqlATp/sDUj36Ex1JoLpM9FVzxrkZ+Na8LxFP1wxBzWR9Z1
X-Google-Smtp-Source: AGHT+IHHqngOXkEUDbnzih53IIYvud+CjZpBukJjI4zseJsAAFNb4EbCmZckikl17w1FCYOPaN0FHw==
X-Received: by 2002:a05:600c:4750:b0:43b:c390:b77f with SMTP id 5b1f17b1804b1-43bd29d557amr21862305e9.26.1741187303674;
        Wed, 05 Mar 2025 07:08:23 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd4292eeasm19788315e9.16.2025.03.05.07.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:08:23 -0800 (PST)
Date: Wed, 5 Mar 2025 16:08:19 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Gospodarek <andrew.gospodarek@broadcom.com>, 
	Aron Silverton <aron.silverton@oracle.com>, Dan Williams <dan.j.williams@intel.com>, 
	Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Jiang <dave.jiang@intel.com>, 
	David Ahern <dsahern@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Itay Avraham <itayavr@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Leonid Bloch <lbloch@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	"Nelson, Shannon" <shannon.nelson@amd.com>
Subject: Re: [PATCH v5 0/8] Introduce fwctl subystem
Message-ID: <mxw4ngjokr3vumdy5fp2wzxpocjkitputelmpaqo7ungxnhnxp@j4yn5tdz3ief>
References: <0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com>
 <20250303175358.4e9e0f78@kernel.org>
 <20250304140036.GK133783@nvidia.com>
 <20250304164203.38418211@kernel.org>
 <20250305133254.GV133783@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305133254.GV133783@nvidia.com>

Wed, Mar 05, 2025 at 02:32:54PM +0100, jgg@nvidia.com wrote:
>On Tue, Mar 04, 2025 at 04:42:03PM -0800, Jakub Kicinski wrote:
>> On Tue, 4 Mar 2025 10:00:36 -0400 Jason Gunthorpe wrote:
>> > I never agreed to that formulation. I suggested that perhaps runtime
>> > configurations where netdev is the only driver using the HW could be
>> > disabled (ie a netdev exclusion, not a rdma inclusion).
>> 
>> I thought you were arguing that me opposing the addition was
>> "maintainer overreach". As in me telling other parts of the kernel
>> what is and isn't allowed. Do I not get a say what gets merged under
>> drivers/net/ now?
>
>The PCI core drivers are a shared resource jointly maintained by all
>the subsytems that use them. They are maintained by their respective
>maintainers. Saeed/etc in this case.
>
>It would be inappropriate for your preferences to supersede Saeed's
>when he is a maintainer of the mlx5_core driver and fwctl. Please try
>and get Saeed on board with your plan.
>
>If the placement under drivers/net makes this confusing then we can
>certainly change the directory names.

According to how mlx5 driver is structured, and the rest of the advanced
drivers in the same area are becoming as well, it would make sense to me
to have mlx5 core in separate core directory, maintained directly by driver
maintainer:
drivers/core/mlx5/
then each of the protocol auxiliary device lands in appropriate
subsystem directory.
It's not always simple to find clear cut though. Like for example
devlink and representors code related to eswitch orchestration.

The benefit would be that lots of core-related non-netdev patch-trafic
would go directly, which would ease the netdev maintainership burden and
would make things more flexible. This per-driver-serialization for
patchset processing bottleneck would become much more bareable.
