Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5282D600
	for <linux-cxl@vger.kernel.org>; Fri,  7 Jun 2024 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717745665; cv=none; b=Qv+u9B2z530Mq59qHcmo00i0EkKZQXx3H6rmI/aS6xeCH4l0FFsqZaBuw3voEQVo+3g4z1EqDDao6d8gscyRwpWp9AueVTALgQhd+dHSBlPY/ji9d76umOqvtcO7ZhVYKRBis4UlOD7ezFm/hJEc+MgtoasnQY6d2l+y0ynw/XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717745665; c=relaxed/simple;
	bh=wc7V8buAFkBh3ydPjed2ipAWNFc5GmI1OVqByAfWSWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjQ3VrMFuN3ACXGSqGNo9riyHe7S8JE4KPi9aAZqasqkNjJG90CoQkRpO2KZUXcbFY4DN4luYrArmsctMAmYZd7Fk0+f9qDiHOOr1UzryaMFIJ9VlsLBfQluprEIS0cZxec4cFh7Zj3Pa7s1OGYeaci8cYkhMhE1qyjdBbPYHFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=q+Pz3Mhf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="q+Pz3Mhf"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4214f52b810so21988075e9.1
        for <linux-cxl@vger.kernel.org>; Fri, 07 Jun 2024 00:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1717745662; x=1718350462; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9p6Ea3BEh/GCrntLXXZZkFilZ40QZybHi/QN5L8Zn8=;
        b=q+Pz3MhfhJdXmKzduBXLRXoBo4ZJKF1Lc2nj5i8EWgeRMLJOu+Yb8ulvKkHtKd2a9b
         oAreJr+aMnnQSewtWckAM30kjNoBouKNwZ+CB705d7ORxkv0chfReUltQNleeopnfdux
         wOOcwtYCyqzpz7UvmJZ+gyQRgB79TgwV9mU74BgOeyRgmnmdqHC7EZ1umdjbCUwaU4n0
         i/TpISZAlfgkWcLN4l7xAsAO0Nb5z0xE57/saHQT3wgLVWHLaQRyGHU01jvJxsXfwcFB
         dWJJqYE/s7ccoXE54aOtHKFCOjEfcmkIbg9AAkoFvnc/oyyph69xU7LKOOBfxqz3Zv8a
         A0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717745662; x=1718350462;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9p6Ea3BEh/GCrntLXXZZkFilZ40QZybHi/QN5L8Zn8=;
        b=wwbV/EQbfZJM/7jiOrYQXX7z5VTZsPfrF0vvAvPKgaJi9yfRMj5Qq4GV8DOtd5aehE
         rn6O34zWyn6MCbh4rGeoN0wp/1vNN2q13z4UwpM0XZKLSdh/cdYfnJTTeSC+VOA0ygPi
         eqgbxSj5TBFDT2PKmsH73PRrw0jmQVaO3LlG5VP5n+7P0t0NoXe0B8lUNg3nur20N4j5
         nSZunCi7iW3PH5isKVpeWbrMy1Si6aHiuSTPSNK8sUj5smrCHbXL5mNHD3CLDr/pLwe+
         T4t00ER39XTs29C+rbZ/FW+O3eAqEvG6JQFVRLAPTDceXDDWZDLnhQL1/72KWFnNVS5X
         xfWw==
X-Forwarded-Encrypted: i=1; AJvYcCU0+G8+nB6fv/ZDrUjQfNtiL9f9UEC11KMl4BL24jNVLbvU8cPLGc01Z7KUQv/S6dmuEKVAUWR6yzLxBYyx3XoWg7WbHFBVg9jK
X-Gm-Message-State: AOJu0Yx1o18moYGukUsYR0DSnEpF+hbGJO77opS5j3d5HkTS84QZJxqK
	+mPK6b2aFcuoshiJFJerf+tnLA1LKmGVKzyBryNftSo7uFKkf/Lt9laJirA3oZU=
X-Google-Smtp-Source: AGHT+IH+3m7gv/wXKg1IjZX1gSf7JkbLx10qHeS1+1YDQg9+/tqA6LeQaS0aSWtLgR0eEgd8FaiPpw==
X-Received: by 2002:a05:600c:1383:b0:420:182e:eb46 with SMTP id 5b1f17b1804b1-42164a44859mr21469665e9.38.1717745662064;
        Fri, 07 Jun 2024 00:34:22 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-421580fe3bfsm79619795e9.8.2024.06.07.00.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 00:34:21 -0700 (PDT)
Date: Fri, 7 Jun 2024 09:34:18 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Itay Avraham <itayavr@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>,
	Aron Silverton <aron.silverton@oracle.com>,
	Christoph Hellwig <hch@infradead.org>, Jiri Pirko <jiri@nvidia.com>,
	Leonid Bloch <lbloch@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>, linux-cxl@vger.kernel.org,
	patches@lists.linux.dev
Subject: Re: [PATCH 0/8] Introduce fwctl subystem
Message-ID: <ZmK3-rkibH8j4ZwM@nanopsycho.orion>
References: <0-v1-9912f1a11620+2a-fwctl_jgg@nvidia.com>
 <20240603114250.5325279c@kernel.org>
 <214d7d82-0916-4c29-9012-04590e77df73@kernel.org>
 <20240604070451.79cfb280@kernel.org>
 <665fa9c9e69de_4a4e62941e@dwillia2-xfh.jf.intel.com.notmuch>
 <20240605135911.GT19897@nvidia.com>
 <d97144db-424f-4efd-bf10-513a0b895eca@kernel.org>
 <20240606071811.34767cce@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606071811.34767cce@kernel.org>

Thu, Jun 06, 2024 at 04:18:11PM CEST, kuba@kernel.org wrote:
>On Wed, 5 Jun 2024 20:35:49 -0600 David Ahern wrote:
>> Until a feature is standardized and/or commoditized, it does not make
>> sense to create a uapi for every H/W vendor whim.
>
>This is not about non-standard features. I work with multiple vendors
>as my day job. I ask them how to set basic link configuration and the
>support person gives me a link to the vendor tools! I wish I could show
>you the emails.

Even without emails seen, I believe you. Well, isn't it just natural? I
mean, it always takes a bigger (sometimes much bigger) effort to
implement things properly introducing/extending apis/uapis.
Implement things in vendor tool is easy, low hanging fruit, people
naturally pick them.

I've been around in netdev for better part of second decade.
I think, for the sake of discussion, it is worth mentioning, that
a big part of netdev success despite complexicity is that in the
past, any attempt of kernel bypass (I recall few) was promptly rejected.
There was always big push for proper abstracted solution. And I believe
it helped a lot all over the place. Is this approach depleted?
I don't know, maybe. (And yes, I'm aware not everything could be done
this way).

I understand the reason and motivation for this patchset and what it
will solve, don't get me wrong. I kind of like it, it will help to
remove all painful detours we currenly have.

My concern is, it opens a pandora box for netdev *for sure*.
It that desired and anticipated?

Do the gains overweight the potential losses? Will it help the
ecosystem?

What is motivation for vendor to take the hard way of using proper api
(even existing ones) after?

Moreover, wouldn't this serve for vendors to go out of leash and start
to introduce even more H/W vendor whims?

I think these are serious questions we need to ask before this is merged.


>
>> All of them are attempting to solve real problems; some of them will
>> stick. We know which features are valuable when customers use them,
>
>Yes, once customers deploy a feature implemented via a vendor API
>they will definitely migrate to a different API. Customers like risk
>and wasting their engineering resources reimplementing and redeploying
>things? And we have so much success move users to new APIs in Linux!
>
>> ask for them and other vendors copy them. Until then it is a 1-off by
>> a vendor basically proposing a solution.
>
>Certainly. Because... who exactly will ask the second vendor to
>implement the common API? 
>
>And the second vendor will most certainly not mind the extra delay and
>inconvenience having their product shipped via the publicly reviewed,
>and slow to deploy kernel, while the first one is happily selling
>the same feature already.
>
>> Not all ideas are good ideas, and we do not need the burden of a uapi
>> or the burden of out of tree drivers.
>
>This API gives user space SDKs a trivial way of implementing all
>switching, routing, filtering, QoS offloads etc.
>An argument can be made that given somewhat mixed switchdev experience

Can you elaborabe a bit more what you mean by "mixed switchdev
experience" please?



>we should just stay out of the way and let that happen. But just make
>that argument then, instead of pretending the use of this API will be
>limited to custom very vendor specific things.
>
>Again, if someone needs this to ship their custom CXL/Infiniband 
>AI fabric magic, which is un-interoperable by design -- none of 
>my concern. But keep TCP/IP networking out of this :|
>
