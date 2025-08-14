Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9008D222594
	for <linux-cxl@vger.kernel.org>; Thu, 14 Aug 2025 15:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755184775; cv=none; b=XUiRXLYAxvaQgOFJLASbLYqvcoq3Z0OcbmXXbs2Yg4m+0RbmWD4rvtrD2JNdV2MAUGAEACjl48m4GxlZNnjo+EMwb5CKVbMgQlObYQNCkRVxXbXy9NZq4czXnGVYlRhZhja3ip5IvuejNshMbtRwGgEDvxIyHAPpG9dZ3SyQrRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755184775; c=relaxed/simple;
	bh=w0w0dvsu6k/K6PwFlV7vPpkTwV9o99ZgnYkwYYG/8s4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlAfRquq0DlAYkhM23GJ2j4BGpdbVLG+VeuxoDU0rs74xW5VQuhFpIA5KRwFQm+Jd8qmv691OzQHPlvZxjVqYBSMAq8ffhAb5ZG8Z3FDWwtXcd6w5LSUAYS0qcm7LTLfO/M9Oy4ugqZ7S923Ajjxeo8Lw4PQ5CUO4WEfD2yXJMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=nLbSPa6w; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="nLbSPa6w"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b109919a09so13704131cf.0
        for <linux-cxl@vger.kernel.org>; Thu, 14 Aug 2025 08:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1755184772; x=1755789572; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EA1ZvFf+qWrndIFVkpDd7IpLWJx6+2D8DPmrDSfzpF0=;
        b=nLbSPa6wSfW6iCCBQoxh4+p9jCDfOizqypU73rXtCjn1BgXV957iRTFTtfAR3X1aK2
         ojqSsWGo4QLxAJmi5KwRfXOo3wvWLyp6gyMHoktgawOgtvte0P8E5OPp68kiup5CY1uV
         ENnEaxbmpkhRj84GdnITQXTFiwiooHB35Gat0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755184772; x=1755789572;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EA1ZvFf+qWrndIFVkpDd7IpLWJx6+2D8DPmrDSfzpF0=;
        b=M4g0HFQA3cRtBybSI08nTGB5z/tMI+2dQ3+yThHFNWMakIA8nxN/vLj2TJDHvofIdN
         rzHW+Wo7ABi8gxSlV/1jriX9PrLsjQT8Q+iOhqhnz/YVnyEXPWZSWkO3M8gjdyBTi290
         xalb64P2XtyEncBS6za2HXRtFAhRq2F48oOV/3YI1Gk92+wkybZpsNgnBk97EKyQcyPg
         QvSyqSuSx3rrxigOIvrX9oYGpdwB5WuWrAr8C8eG9DpLgDlWH1Z9ZVelRZd4KVM1xKxV
         ZuCfQa0JwXedrIlvYTZ9ttDui9ivwMEdhuDxcIy4AgKyoSwgNd+I05B9G8/0AiJix14K
         KhQw==
X-Forwarded-Encrypted: i=1; AJvYcCVbLHMXWAiy/J6oYDrr6CCCShbnTWwXbyV+qLi7bqtLgUOqZNADxZ0Q2K2TNfSAGdDEj0fc4grBOWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl8d9ZsEAJRRS64hy0jyCgphTDIqOMkRJHew4CAWKVmAdYMLY5
	H64aEo1zE25DOu7sLnwQLg9EiEBjEjIjNaayc/Pv0/RR9MIhXgcgeZhOpDxOVTG/wUDoZflQwSC
	B29Jx0efz7jUf9M+dzAsKhCjGe6DIl/yVci90q06ZgQ==
X-Gm-Gg: ASbGncsjzvVnwRTn9XG8LLE/IX68yQpiUA1c9Wd12a9oJtW4hmNj8gL+/AzpfWjJnhq
	9su/nsa6ig/qg1cZTvsuEhToBDt9XHYP4tXgozcChyXam8kvT3plNiXg2O5ZdaqvjtVw8OYk8PX
	mfXLnXJr2st+CpM2+JDV9019hzCW49/P6WmR/UgXJjgbCt91q+HhkAFtiPOKMmGxcDb9idEwxwE
	Hn4dCqj
X-Google-Smtp-Source: AGHT+IG2qa/e3q/lS7fdE17E/mieIqz9XZskfeQdm0xkHvlzBuR85dHk6whip69ESAWWHza3LlnZuCoCgfbTex8i3Ho=
X-Received: by 2002:a05:622a:5c9a:b0:4b0:7327:1bf5 with SMTP id
 d75a77b69052e-4b10a958412mr55498911cf.6.1755184772275; Thu, 14 Aug 2025
 08:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703185032.46568-1-john@groves.net> <20250703185032.46568-12-john@groves.net>
 <20250709035911.GE2672029@frogsfrogsfrogs> <ttjh3gqk3fmykwrb7dg6xaqhkpxk7g773fkvuzvbdlefimpseg@l5ermgxixeen>
 <20250712055405.GK2672029@frogsfrogsfrogs> <CAJfpegspQYVbWVztU5_XFwbGaTQKe2NCm2mcui6J3qv1VDxdSQ@mail.gmail.com>
 <z56yzi6y4hbbvcwpqzysbmztdhgsuqavjbnhsjxp3iumzvvywv@ymudodg3mb5x>
In-Reply-To: <z56yzi6y4hbbvcwpqzysbmztdhgsuqavjbnhsjxp3iumzvvywv@ymudodg3mb5x>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 14 Aug 2025 17:19:20 +0200
X-Gm-Features: Ac12FXw8eO26MUJ86ncWZmuTB9wijlUFGNEwkcMvFc2CD_KfkHGAKLg17yDdXIs
Message-ID: <CAJfpegsQxSv+x5=u1-ikR_Pk7L+h_AqNBW1XxM-b1G2TLPP4LA@mail.gmail.com>
Subject: Re: [RFC V2 11/18] famfs_fuse: Basic famfs mount opts
To: John Groves <John@groves.net>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Aug 2025 at 16:39, John Groves <John@groves.net> wrote:

> Having a generic approach rather than a '-o' option would be fine with me.
> Also happy to entertain other ideas...

We could just allow arbitrary options to be set by the server.  It
might break cases where the server just passes unknown options down
into the kernel, which currently are rejected.  I don't think this is
common practice, but still it sounds a bit risky.

Alternatively allow INIT_REPLY to set up misc options, which can only
be done explicitly, so no risk there.

Thanks,
Miklos
