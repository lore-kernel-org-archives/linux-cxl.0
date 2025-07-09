Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E161DF970
	for <linux-cxl@vger.kernel.org>; Wed,  9 Jul 2025 03:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752031626; cv=none; b=AwnHcfdAfd+9eUwdOS7jzQGEiq/Y2i+yFsjiQkELt61ri8vjhpYLhA4MP5fdotNGfUdsvrW/2NZFGa0MgFTaF0P82S/Y5gzpgcVh7xOqsgvt8c19FUAJFk8RoIMYEolASM/hk6WtbDaVYUmCy8X85tGiv+K/vTRrGcK/exZTuy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752031626; c=relaxed/simple;
	bh=zw/fej0GkXW5A++Ge3FEYjbMmbv+hTBMbj5gw+U4//w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LP3gaKTmvYfdE/KqK+cVWJe3cJiq9xeeDO+/zybhAHfVdHsOGmQ6vJ8dbxoKoXuF291LRiTcbJyaQCcNNH8kiLUhg0yQFSKOEUD7rWDnETiTSACtXMeJVQ7Eunql+r0vz1ObavW1u+zV8GI9CxsyARrwqNUv8VeCd4PViGf9xxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=KXQxlaqY; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="KXQxlaqY"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4a58d95ea53so7336791cf.0
        for <linux-cxl@vger.kernel.org>; Tue, 08 Jul 2025 20:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1752031624; x=1752636424; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zw/fej0GkXW5A++Ge3FEYjbMmbv+hTBMbj5gw+U4//w=;
        b=KXQxlaqYQfw0jkMx0UszkFkz6yZAkJym2Y4XdWw6DJwfxo7h8FDx3GciGZ4GfjpWq7
         2by7ourxfJDrIk221f12+zzD98YK2TkxAwAEVam8W15bHr1Mj1EDYPPa85YXU51sAsSQ
         /b/56IISOz1C8GvDDn5t0r5YCFfLOOHuTQUNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752031624; x=1752636424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zw/fej0GkXW5A++Ge3FEYjbMmbv+hTBMbj5gw+U4//w=;
        b=M5X8Rkw5neaoYPUbZOYNFEGPkCfsNm0o+w6Sur+3NBxgb5YUYkgXxuJ95xefpZPbyZ
         NmQvx87VUUL8SKmE+vk7GKDwZtsy1DhNu2LmbSr4Ysv8m7ZqDNlW5ceFA0JVgd4LgI07
         TlmdrsNQf4kEYBN0IKdd/FTGXrLZqPAR7kFZ/SpG2F/F5TB/d4FvVH7ynjFXW1+dyZcD
         0Fao/naoZzBfbzLwAAi+nMdVUZQtIpduxU/Cm3OMWaYi3vEjW4ShLs/IDMj0/WBGZ5+v
         PZQiflmP/8HDls0sd81Ha19xdVeO9ajbIgLYDojwiPojEu/2PmP/FcqE1AxcqDDNjUuA
         t9ww==
X-Forwarded-Encrypted: i=1; AJvYcCWHUg/TRxXSHwtEe7PnL6R09qWQvOSZu4VGiuW+pnLcuV5TJ8S8/k2m8kBefWuOC+PjYMvWzTyuu2U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9OENgvU8DP9QDqizxkgHAqlaTCDmZOfcxsxgFVYFTo6skfT0o
	qZOjm3FSe1KyP3837McFqRgl0xA2vg9pR3McCANJ1hpeWmyuk6hYH86C9tfXVkglUMCGxCh+S6L
	6f8e7zxn10w/wGzLi6BkMjT0a4nwG8dM9nn+JDswuLg==
X-Gm-Gg: ASbGncvbjNd8n52qsjevFHndvxyTqf9RAxy44F26pCUcVRyLpTMvjcK36X/5QTKW5pr
	TFsEVO1kSkjtjYoNQkF/KES7GckDt2+nM64Ds570pJHTyFLrsXgwDRh31jtMCs7yCSkCFuQNDjg
	iDFi8Oi05oouGRIM4EVP1f7Ybh8pCWpCLBaJX8YMbZdwKV
X-Google-Smtp-Source: AGHT+IEbfuPtiB8SJ8mM3IIy/0e+1oWhx4UxNRjIANMV3UTN0UVNRrT4FqNMCrH6Q0szGd55OwaVpm23wRX15i4H4tQ=
X-Received: by 2002:ac8:6f19:0:b0:4a9:8b58:6300 with SMTP id
 d75a77b69052e-4a9ce5bbb43mr86267521cf.16.1752031623903; Tue, 08 Jul 2025
 20:27:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703185032.46568-1-john@groves.net> <os4kk3dq6pyntqgcm4kmzb2tvzpywooim2qi5esvsyvn5mjkmt@zpzxxbzuw3lq>
In-Reply-To: <os4kk3dq6pyntqgcm4kmzb2tvzpywooim2qi5esvsyvn5mjkmt@zpzxxbzuw3lq>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 9 Jul 2025 05:26:53 +0200
X-Gm-Features: Ac12FXw6hgYHynMi-MN39oWlDifPLmPqesU1MFQWRlURFDaTLnL4XYV-SQPgaEw
Message-ID: <CAJfpeguOAZ0np25+pv2P-AHPOepMn+ycQeMwiqnPs4e0kmWwuQ@mail.gmail.com>
Subject: Re: [RFC V2 00/18] famfs: port into fuse
To: John Groves <John@groves.net>
Cc: Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Jul 2025 at 20:56, John Groves <John@groves.net> wrote:
>
> DERP: I did it again; Miklos' email is wrong in this series.

linux-fsdevel also lands in my inbox, so I don't even notice.

I won't get to review this until August, sorry about that.

Thanks,
Miklos
