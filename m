Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD02D824AF
	for <linux-cxl@vger.kernel.org>; Wed, 22 May 2024 11:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716377337; cv=none; b=dWta5eNk2joB8PIPwuUW8b9SVpdh85Dx/iyq6tWiiw7T2O0YqhEjs07/roCtcYydJgKolRoogu/SWNdrm1EKD1olrw8Stx1vlBhbPLFNKUSLrRXxKSlqxtkVsMiq5OzinATb2PIWWOm/lHJUo5hERO5LXyOG/f0Dm916gBVEdos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716377337; c=relaxed/simple;
	bh=3bJdJ8HW1Na5LLk+AGH4z17x+8X++BBtE11tCH2eQoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0vSd0rrHsoMypJuPQozIHIestbcST8i92/gDOX359TKgoaCwPLeHGJi7c9bqmQrHr19niQC2hN76A1AGWHf98HLyoQLFxQ4/dh9n/utPC+ue7BrCez2hMnXM0efE/9Je6BYfGs2qwbyC2M/tY6vB8qe/KZEmNrcDxCs/TyxBfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=eN/G7J8C; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="eN/G7J8C"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59b58fe083so704302666b.0
        for <linux-cxl@vger.kernel.org>; Wed, 22 May 2024 04:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1716377334; x=1716982134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KNstTbNFBCd+HhKurLCnuPWR0z0UVPvAuThP/LhWOd0=;
        b=eN/G7J8C84raWniw310y1EpLoZrKwLRk8mgg2G7az7jscCt1S0EKldbn0KOnIM0Wig
         FckEbk4wH6bxTI7stUKHNpy1VZ90169MBrB3fc/d0orV8/chSi6s1MkQCehitRS8qO95
         M49TXOAMAZwn+PCAl7RfhPgx4AH39pdgIndIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716377334; x=1716982134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KNstTbNFBCd+HhKurLCnuPWR0z0UVPvAuThP/LhWOd0=;
        b=ZKQs4YNgL1/t9wXur0Fni3g8vVKzZ7/5XaaoAHRetZ7cO4Yhcq4/pu6cuAG931Nnls
         7lqzQiVM5c+UGoQUIi//cqI0gy+uWwWb73F0Jw1R2BHFiSJZPO5t67VkYgbcb8MXi03U
         jWd8AvXCqSmdWzYiCL7ikey9LhJa2R9t3ebM/a6+cnYwHtIEwUazBpc4IakpYw/i6qCf
         UbXNI1rEa6eFFFpnarVLy48yt5rsBPuqI5lz8iAgl7iUESEqil1g3/Ftuj7tA7U29hg9
         KYfZWcVERLyUqtEZT5neZnXyU1tD0uApjhN0MQ+VWdjBx+6lNeVge78h8xaqjVNbzrsJ
         egKg==
X-Forwarded-Encrypted: i=1; AJvYcCVzUl8m1DjUMM8a/iH3J5l6Alm7157CPlOGQUnlySrMVzrc1p4OOIt5w6AQ62SFX44Ma1qqYnx2ogG9d8i55w88qDUPbSIfz8Hu
X-Gm-Message-State: AOJu0Ywha17sJG8ti6VeVoRoCTdLLmgObOwkgSgKin9jABtf3EaGX5bU
	acDc2eeqmGRlaZbGNiG/zwkrEQ+qvx3TNtwXB4IyoiOiMLYHlrJZ/G4A3wSBHoi1bKI3Wrg8Wpa
	j5E0/FDWDXPLmzfxaLR2Ka+II+jIP8gg+bTnDSA==
X-Google-Smtp-Source: AGHT+IE5WaF87K/wVsaT0a6gSy0rGBzZLsdh108SeEf5aQ3zolCWJBW1NV7c9ET+Od7JRp7Fevvf53iJJIu4qKo7s5M=
X-Received: by 2002:a17:906:1589:b0:a59:c52b:993c with SMTP id
 a640c23a62f3a-a62281fc3b7mr84214066b.77.1716377334095; Wed, 22 May 2024
 04:28:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1708709155.git.john@groves.net> <CAOQ4uxiPc5ciD_zm3jp5sVQaP4ndb40mApw5hx2DL+8BZNd==A@mail.gmail.com>
 <CAJfpegv8XzFvty_x00UehUQxw9ai8BytvGNXE8SL03zfsTN6ag@mail.gmail.com>
 <CAOQ4uxg9WyQ_Ayh7Za_PJ2u_h-ncVUafm5NZqT_dt4oHBMkFQg@mail.gmail.com>
 <kejfka5wyedm76eofoziluzl7pq3prys2utvespsiqzs3uxgom@66z2vs4pe22v>
 <CAJfpegvQefgKOKMWC8qGTDAY=qRmxPvWkg2QKzNUiag1+q5L+Q@mail.gmail.com> <CAOQ4uxiY-qHSssaX82_LmFdjp5=mqgAhGgbkjAPSXcZ+yRecKw@mail.gmail.com>
In-Reply-To: <CAOQ4uxiY-qHSssaX82_LmFdjp5=mqgAhGgbkjAPSXcZ+yRecKw@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 May 2024 13:28:42 +0200
Message-ID: <CAJfpegvAuPtKzR1A4GdaZTB_EDqPu53wUf97D1QOUo9VKkTV9Q@mail.gmail.com>
Subject: Re: [RFC PATCH 00/20] Introduce the famfs shared-memory file system
To: Amir Goldstein <amir73il@gmail.com>
Cc: John Groves <John@groves.net>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, john@jagalactic.com, 
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@infradead.org>, dave.hansen@linux.intel.com, 
	gregory.price@memverge.com, Vivek Goyal <vgoyal@redhat.com>, 
	Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 May 2024 at 12:16, Amir Goldstein <amir73il@gmail.com> wrote:

> The first open would cache the extent list in fuse_inode and
> second open would verify that the extent list matches.
>
> Last file close could clean the cache extent list or not - that
> is an API decision.

Well, current API clears the mapping, and I would treat the fi->fb as
a just a special case of the extent list.  So by default I'd keep this
behavior, but perhaps it would make sense to optionally allow the
mapping to remain after the last close.  For now this is probably not
relevant...

Thanks,
Miklos
