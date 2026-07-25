Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439951D47AC
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jul 2026 04:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784952106; cv=pass; b=C+NC+mcDZjzQ6jJDF36iYDeIOj8wU//EtH39JSdPrGw1ie1iOlExN7AwhboR+6Y9PLZf0dx67YT/jQwJqyIxjMsMwdzFjyChzqunaT6AUFKntUV+KqWVAdOHul7vUjOdL9eZlbKgnvBeLVKPaz+19+lDVrMvudLRnFknT8r1pSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784952106; c=relaxed/simple;
	bh=fNC8wElaBgCywizq8gsw7GvnGpxJrTKPY2EQunJ50fQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUqQn+/mNlh+TObpWCPAfXD4ClXFuX0Joh34HFLae7PvH6keG4kR8nD+Qsc/FS5pTmHnubqBSSJ9XdvBVS1/SDyJQAU6caaUOnI1mMJUQrSsbCZhjSXpGk0tJMwJQaRgnXEEFj01mbIjTxLCxln0kMybJSwkCpy1TdMHO/uQyY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=CNAZJoN0; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CNAZJoN0"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-526f963372aso9481481cf.1
        for <linux-cxl@vger.kernel.org>; Fri, 24 Jul 2026 21:01:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784952103; cv=none;
        d=google.com; s=arc-20260327;
        b=L3w3tED+Rh3iVp7V76C0MUEKiYWsbDumXirmMSDoHP1TrOijSpZbk29zX6mmn2Hd4J
         F+G1TvWciYJojQbOLj9s3TWMirUJ3x+1ExnMIMMbfxa4oyJLDpj3R8FfEulm8BS92Khf
         BPAovFQKKlOqSQx3rdSE3urvZ9P6r1506f6Q8E+SDYu2pqhAKk5k1olEeJa4Xw29nyDh
         9KmejPS0A38HPuO2bz0gheIUR7ZspaBtdUC2V1dJ7y7QOjLTxO40IlUnejP7LU2aesR3
         yXwg/areCg8eLH/vHGcxOQomQZKi1rofVolvJOxyEaCI2+vhk0/dBMWpULw10GL9dFRj
         WLOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CzPMjf6pORP572iHiiQv3possHTxsjbSzVUS0tfn1HU=;
        fh=K8UicKpuI/TXyIZMTBF+FjZMhDW+AsC3U/tzzO5zevk=;
        b=PjDAWltOhB45qN2iK8bzjnc/YOFNEyk8s02nuuPImjfVrQmUoL+JpkZT5fY3KDmXR5
         szVK30pbfExELytBcgTOLLxYbX/2f7UkOmCHpcyDLHVWqwLWJGwjDPBombi7IV5rHgc7
         V8g+WagVeBYvfsv3/0qiDvuByE0EyHUxFqZ4ofjfUL3JbC8TvpoWPaYdiMm13ImNzFp4
         jh8/Txj1Ifik77gVjSANrpNlIvBa8NIxMYvyZA576y8lORd4i7sbbYMux9bXheTAU4Gq
         S9L8N9ck3dK6yRKvQpAG/KHJValJsphlgbZSBqTPA8ovcfmcRnHnqhbd9/U9YMpZUl16
         nyGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1784952103; x=1785556903; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CzPMjf6pORP572iHiiQv3possHTxsjbSzVUS0tfn1HU=;
        b=CNAZJoN0GTGYkkNaC+LQwZa9ZPYftYSqqF9YnFNyEv/DFmrM+msE4JBCrJb/oKRqVL
         hih2RSoXP1ImRcm7kDGVqmiKReSP64UzzbzY7d6sGRf3Iz+pK7OkARtstKIc9iL9J3Ko
         Jfb6ddY0nBEAbcuBHouUYHej58F60A0BJgcIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784952103; x=1785556903;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=CzPMjf6pORP572iHiiQv3possHTxsjbSzVUS0tfn1HU=;
        b=kI+exsqhHSVsnFSk1AUQ42SmZiT8u7jREsyNt+cOk/RzjdlpRBqrx76e/80SMk5ES1
         kL0uH8tucP4GpOQtGSg22YZSd1Ik0ukt3cTX8o677gZY8fnzVzGdWhvkjYc+tMYyW+9U
         +qULvsJFfeekPDPDInBcPrjBpfbGn5NCMFhd4O/yTXW+FGDyDLGxjl6yRfI2mhkMDpqi
         vi7Qmku2WGaIT+H4h0AYRH26DFljlkwnmMpFj1QCuEHk6V84Ui/NKp0/3SPH2QstKoS2
         o08hnDGGmJpWdbRd/qvjccpdiCe5VM9SDwJov7uKQISquT32k2rUg0uvXiUZFVb+K3mL
         8dKg==
X-Forwarded-Encrypted: i=1; AHgh+Rr2BC6FJqYbVOnf6vypweOkZVAxV+ym1Jqt8AoWUtws+nlU9mqjjKjbIRHcqjpPA6JAaQx+AV7nM8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSUMbxD8b+3M9eF9/m3QRGfUsTmGJteIllvobKies27u5h9dUt
	oj9wvv7SLQaE18okTsw7OAxeEAnixcD/eNJtBpgkRiwrfi8U7sS5vbG/EUhhKDK1HQxwC/QaIRa
	ITqKTD7FWgOTwcDIS2BqN3sBgT/hnLJnanRfqD43mYQ==
X-Gm-Gg: AR+sD11BR8rcPhuNohzRNrzbZs1VpliPKvX2OfivhEtTtayxOkquGDieGYVttFTFI9+
	c9hZalBKpJifIBHrTiK903ylEdLh+YnfV9Fgd1w4k3dkjDrHSjO8roc4T7ZkIXacXlo/GyytUJ6
	4as8mruerSLXf1Nm02IwDJNI4d63BfyA05qhN5NxIPyeaDxK7zpqqjwgTUveUzXnwveReYanveL
	dCh2COg9Q/wYjfVxtwqSV7rG2TYxIlE8g7ze51435scI/8Aj5GJKiO2ZQWiM3+77ZcYkfxygatK
	t6SojVk5w2Fd8SoB
X-Received: by 2002:ac8:5c90:0:b0:51c:7b12:6001 with SMTP id
 d75a77b69052e-529a8714e88mr10045521cf.77.1784952103086; Fri, 24 Jul 2026
 21:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720034358.68714-1-john@jagalactic.com> <0100019f7d9fbe81-6cb16662-2522-47ea-a152-fab0ee3d9b35-000000@email.amazonses.com>
 <CAOQ4uxiEzP2e=cRw-AiGxtSv6WMSA5yR3cmgrF97s7ggU6wzqg@mail.gmail.com>
 <CAJfpegt9PwHksYhsQZeCsW0eooXVVihyieTpeHMmC-+Pq8BWaw@mail.gmail.com>
 <CAOQ4uxhuivjMMt_Dm3VwKmOhHg7ZHdAww6j6jp+RMjPoRde+bA@mail.gmail.com>
 <CAJnrk1Yat+SEr=SmZXwUt9y2WcC0VEC4KUpPrkrRSjMEmx42WQ@mail.gmail.com>
 <CAJfpegtnja6tkOnNPD2WZxu14Dd+UM9AvynsVB_E268iSXLbkQ@mail.gmail.com> <CAJnrk1a9mR-6hFie3hfFRgWTkrhJMVx4j9e7WGnjTRFuX2iJOg@mail.gmail.com>
In-Reply-To: <CAJnrk1a9mR-6hFie3hfFRgWTkrhJMVx4j9e7WGnjTRFuX2iJOg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 25 Jul 2026 06:01:30 +0200
X-Gm-Features: AUfX_mxAcvr2jX4Ns3aulDhtsSqUabRQhwz0VnV0bbRi_FBtOFn1nR0cN_FIRKA
Message-ID: <CAJfpeguEptz4sEXq=pBWPFop--1kTDu5p2yZnCyzXcrZ28Nekw@mail.gmail.com>
Subject: Re: [PATCH V11 0/9] famfs: port into fuse
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Amir Goldstein <amir73il@gmail.com>, John Groves <john@jagalactic.com>, 
	John Groves <John@groves.net>, Dan Williams <djbw@kernel.org>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, James Morse <james.morse@arm.com>, 
	Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"fuse-devel@lists.linux.dev" <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

(Replying shortly as we are starting now on a two week journey.  Won't
read email during this time).

On Fri, 24 Jul 2026 at 22:23, Joanne Koong <joannelkoong@gmail.com> wrote:

> imo these changes seem doable for making the 7.3 merge window. I'm not
> sure how much bandwidth John has though. Maybe one idea that could
> work if John is completely slammed for time right now is having the
> changes requested above be a separate followup series someone else can
> do and then this current series (after the sashiko fixes) and that
> series can get landed together in the same merge window.

I'm all for it.


>
> >
> > Maybe the striping setup can also be done with a notification.  The
>
> I had interpreted the FUSE_DEV_IOC_STRIPE_OPEN patch as implying that
> the mapping gets forwarded to the kernel through the backing id in the
> open() reply, which I think is how Amir had also interpreted it. I
> didn't like that the striping mappings got sent through an ioctl while
> the simple mappings didn't, but I think maybe the patch was not trying
> to suggest that and I had interpreted it too literally. I like the
> striping setup through an ioctl - I think it makes sense given that it
> is connection-level instead of inode-level.

Yeah, the striping setup is on a different level (like we have with
regular filesystems).  So I think it's not that bad that the setup is
different.

Thanks,
Miklos
