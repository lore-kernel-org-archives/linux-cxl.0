Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206744A8FCE
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542415; cv=pass; b=fHfcKwA9ryKg/w6+W7uxs88sVo0m3OWa3tHQLiE0JKjzSQrBVUj5HhP8yJe/vFxYDF2Hp/ulCiltiT79PJz6y3PzfpmASLcsGGurGYq6X7v0/BSCVBkif7Pq951ouX1UNi9Ysyv0Ul0qXh8H47nzcQONnxRbQUyRmjxNi3ezh/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542415; c=relaxed/simple;
	bh=TdmxEYfYtkSXgsQopCBGSZ8pT5p6msP1oRfZOE4Yi+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHV7CxLzqdLnpO4MyCLSwUuM5xCIKdhXnYQK5xm3z67zJ7RYHCgw2wQJwD3mAx1+P6GM1wpQWiMBVHOXKzOQy/NIePfm4586Q3OzB3lnu4/c/0BDGZOdDiBpcIGeov2MouI9S8wQ/IBNvc2Ug82Pr6+AjbQYy66xGh3Py49oD34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=DDA3cB0o; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="DDA3cB0o"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-5351748222cso49242751cf.1
        for <linux-cxl@vger.kernel.org>; Fri, 09 Oct 2026 03:40:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791542412; cv=none;
        d=google.com; s=arc-20260327;
        b=UzyDUA4tIcC2JYX4ZmMmDXoNrokPMu4t0lOal7dWeW42bpIEpO0AwfHYEeYV/0jaWp
         m2p76LMZDqQ4vlxzLuQoluzLpk0eFrKC4Q4VOySLG6XDztKTdlcqzp421qSMB1chnRwU
         468kNF66s7PwePARZU0rsyywkVcycywsuIf2R0V5tHwgI1FY9DYC1Z2krIkhoNu6B6gr
         4BbimNceCKo/7aPvsp2xjjkbmbnD5jkOHmTcBxnNo7XC/1siK6aOEjFGQLa22N44UKI4
         iMw9sQbY7io7K+ryrYQGfTXpzy2S051GBvEcMMcrlOOpu5H7YR485MhVLyQ/YJ/oMDz8
         eY1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Dj6hvZEw0Eh9ZS8EwZEyRVpYOqz/OSg7EGiwmx0le9o=;
        fh=JI8cuN8x3K3aFffCDwVDYB/Vdjskh4Z6aDZ6iRclz90=;
        b=dcWdJ9I8VLGEDxtaY6umjODzvjm1crW1fbJZhuk4opIB/j+H6Nusp19lIhofn+5T2X
         QU6nkvxqV+Tw5fbB6VGcy9dKQM2ifTT0EAwm+qwkkZNiQfo3Qzp8/d8ranU7Dh4Z+KTj
         zbTSG+gZMmbf8o4b7O0ioqPgSY2qK+Bt4bUui0kC7gyJ4mtpvY4WKTcUD8OZn6iiTsAJ
         zkBv34LuJUJM5Mtcxi6Gto6og4lW6wBb/RKBxiDXh1dF/DiXshUqXMUoon5Ypm5BuHuT
         Ezp6xigeIuuYKGIi4NvjhYTckeIdGqfK6WfgM0SEYvkPqW4hIshUNwokiTMLR3nYSzla
         DsYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1791542412; x=1792147212; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dj6hvZEw0Eh9ZS8EwZEyRVpYOqz/OSg7EGiwmx0le9o=;
        b=DDA3cB0o0DC13qJYpeL+4/H1ljU1MtVA9XxLQkxZeSgo33uuIJueHOkp9Eg3a+E1AO
         G2uFyIbx4RYgCNHtGFHxJNySbUVdY+YQsgsCDHJ7+xosLGHa/HpUco9XXgWzI3l5m50x
         aOpNr1KWp6XoaeEOM/DLUge8b2rVpwhPYGFVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791542412; x=1792147212;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Dj6hvZEw0Eh9ZS8EwZEyRVpYOqz/OSg7EGiwmx0le9o=;
        b=VKfNGtVfzMlLoe+88YYem+lBBR1tH7uqo3ZHEydPWfYEDUP8RrKFv/6HW5V8VGHkDg
         V05BJulhNE8Sga1YFv7swROmWgHaJB9NvqJZc+N5v4/bYXTjwnKuNDL3mSWZPvm46uoj
         Bsex+t7JqU02pKwFh6aUfS/fkLWPNBKbomc9xHl6zn0/tJvkuoOPtZkDrySbLzrhT7Yg
         lE8pVch4mrcprq0BGFuhpgtftRoQmI7qGHrZdUi0bWd2ttWUfv1E6i6WHOAnHBrs7/Wx
         FvN1fX5IMPfOf1WToFdCkY1lXK+/l8v9vyJtEt8THM0DaxdZPCI5Fd009QWgv/1QdKnR
         NCjA==
X-Forwarded-Encrypted: i=1; AKwUvBwntfwZafQaWtW3fB0IgX6A6PCxP0JfsuI69UCFyw+OaZTAdfbDaLuP84KFM4YEVQCUiF+Pjxfon1g=@vger.kernel.org
X-Gm-Message-State: AFuF++lSVX/g40NNJSQN+lJ9+HBV4s1DzKXkAR6XUTwi6QBG9jVmA23r
	NpoDyOSRwAnCUq4QNrrr0FUol5N6fGkUEV7ANoLpOLq2T119c/cOsbztVtm2aDfDzpD8Fg6o+01
	tZiYx3v4lDiP6Ke2JWETNXXIFdAe3jPX+bj1U42z/gQ==
X-Gm-Gg: AYBFou2IjZedz9au7ylVcd824xrNSm/Hu1wUKV1+VPxC9j/+F3Xzlz6/CsM6EwJtNtO
	lvdRsapjC4LIUMsq/LHpeZTJmxyQj8/6RZCSla6t8tzbEKgHNX2Ac/yvzioYY+weinb6umOR4g0
	wQ63aOqzfI3PfpdIZCNHg8/O+6UklvCARoEtlFzcT7eP8kpbnxXjs0YZhLfCzxCIApCV1ASBiOA
	KGYtiNe4ShQSdmbGrhYJPqOODfjpE1wpEY8Dko31cQrkFgOSi6jl7g48YP1L+vqE8aXAjnUDPhe
	yWJKQOFRBGYtPWXBPYggJcgeTJ/BfFdDQUlOLIOv2+/dWljGPmy1DK61cCjT/U7ph2jk903YB2q
	MReOFASfSwM68
X-Received: by 2002:a05:622a:54b:b0:533:6f90:9e7e with SMTP id
 d75a77b69052e-5359fa918b1mr20240541cf.27.1791542411710; Fri, 09 Oct 2026
 03:40:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261001150935.655979-1-mszeredi@redhat.com> <asQcBebepPb9CXzS@groves.net>
 <CAJfpeguEUTYk9m7g2gZTMui0yFDYWSGL1SZ9PvoYiCqjDmHp9A@mail.gmail.com> <asZcsPT-Q8qga0SU@groves.net>
In-Reply-To: <asZcsPT-Q8qga0SU@groves.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 9 Oct 2026 12:39:58 +0200
X-Gm-Features: AclHuK9bZ1vBizXVx85EODvHCHAG09uRctj1VxFiQmSS5BJHJIYfB0DeoAwYH60
Message-ID: <CAJfpegtZvQsu6gD1-zXvmELcu1-93ZKKEdKHMXqHzChgd_TXKg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] fuse: DAX device based extent maps (famfs)
To: John Groves <john@groves.net>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	Amir Goldstein <amir73il@gmail.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, david@kernel.org, 
	willy@infradead.org, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Oct 2026 at 01:00, John Groves <john@groves.net> wrote:

> Fewer fields is nice, but it's on the honor system that the server allocated
> large enough strips - since strips carry the chunk_size rather than their
> actual size when CYCLIC is set. IMO it would be an improvement to add the
> chunk_size to the header; then the strip sizes could be validated.

Cyclic maps could easily be generalized to not require a fixed chunk
size.  Giving a different meaning to extent length (strip length)
would break that, it would no longer be a CYCLIC map.  It's an
un-generalization that has dubious value, since the strip length is
implicit in either the file size or the parent extent length.

In other words: make the server validate the strip size, and all will
be good.  The kernel really doesn't need this information.

> So that's a bug. I've fixed it locally and will share that in the next day
> or two. I also needed to refactor your patch the famfs user space because
> it disabled ABI compatibility with some older versions of the famfs kernel
> that I'm still supporting users with. If you can wait to patch that further
> until I share an update, it will be cleaner on my end.

Yeah, thanks.

> Having said all that, this topic seems to recur and be contentious - we are
> working on tests that can demonstrate bottlenecks - but my current ask is
> that if I can offer an alternative approach to rbtree that is better on
> paper, can we please use it?

If it's not adding complexity, then sure.

Thanks,
Miklos
