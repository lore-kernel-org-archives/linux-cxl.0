Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02973D903C
	for <linux-cxl@vger.kernel.org>; Fri, 24 Apr 2026 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777041339; cv=pass; b=ksgQWJOTqmEWe+wBxVgFc4upNJd9prh5KwttSeKej7NseDPzSAK8IVHl+d+S4OLqzc+HEElGfsU0EZ8W8hosLZYoVkQeW+TQERD9so1fK/0EwRzha9+B3gtVPad8orVDaCB6D4Y6FTye9JEqE1FSuTQkOvdIwHGbUKd7AIRgGG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777041339; c=relaxed/simple;
	bh=p9jt1gHiba+dFBOeRmZKFoj/PrXR4D3UohMC2L6rPSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzQoI9fZASr9IZNuLYXlL60HJj8D4oKnSHwQxXImn1dwNGwvjABpAYPy5+I6DGE+QWpr28T4oNXLQzG2Uofuokr1i2uP6Cjyfokj9iIi86iQBoL0Mffjxol3anzrrvNJ78DMvq27ivYQ5UNQshAIrF0unztONCbGtq/3WaS7/IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CG47VSy+; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CG47VSy+"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ba5b107eaa2so704780066b.3
        for <linux-cxl@vger.kernel.org>; Fri, 24 Apr 2026 07:35:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777041336; cv=none;
        d=google.com; s=arc-20240605;
        b=htQD8tiiNLzEmR6m6gn2cHRtV/ulZ2P7OPMkZReRVMqGTElNuGe8EJztYZyYjAW7Nd
         M0zc5/gPnBHspozRSG/u+6C3r8j3W3oMRKimOJ2u4wXuIlkVZuEHqLuDdNw70bsoNCTV
         b9VObIebrzt/gV9aSM8fXD0jOrP64cdbMwEfrsc976qEd4KEUqiY/9F5Fasy2Co7T3yc
         Fpj0JSMf3hOzgGE9zy8yQzKNWl5wxedE/7qYYNcBbuGc/3MPX6+a/Kz91xo0StCJMqSI
         UUNYrqw9hS/OH/pClDa7yjrk73jr1lU3v5axIXm4W6FLML8YijCk7sUWFCSmvE1UkAz7
         TTmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wytk7xcJQB1xNQvFPDmiI04wJ1luZnUZ5xfDJ7i2YWg=;
        fh=3BQ0kYUVVLRIN1oTpgZPxchDnPSwgMLBi3OKhIKF6j4=;
        b=KYI/FdvHt4ssxTsYvh2U4Hmb4ItXiVM9xCkQ17YeybTE1L80j7AcIcNz7LGnOwfWAe
         QUG9W4FGtqRCFQQWRmsK98JH8SnY9Z4avBoSnrzl3b+4eQkb2DAjKo05ljVdG4mNs4Tc
         q9qoWuFC/aF6AH8Pp3D8dRCUZZ2l6pYdcppnfLkyhqJvaT6mRMSEmVi5fPynR+MPYfyF
         xCSr6IdNI58IdpPssA8Qj9Bkhy2H33Ps4s8vVgu9ad7LIrUPwfOpqD5taX6Sz1Uuo1rj
         +VxGM14iYGcmX/p7WMv+XRMQbV+yj7MlBdJcJXu/pScswOPnYlOW3CRmPEjykdqHGm0/
         ZwkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777041336; x=1777646136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wytk7xcJQB1xNQvFPDmiI04wJ1luZnUZ5xfDJ7i2YWg=;
        b=CG47VSy+zOLdWI83PngziBgYIMIxdBsxYBEhf9wVb6IlTbadR3sgMoJLLOAP0P+Ekj
         o9xF05II94+16RyKjQJJM19hCib6bmSSmcWPol7uFjuKXRX2zhmqtfQVrJxqoq74Km0f
         apDMbRbr4g7F9xsFG6PUAQkFjjLmD513Z8vSBZrsteix3q9Bgmx4ZNM8/Qfbu/rhGCOm
         ORsqrVeGnRuSLTj1vu0r+bk3/9PGWnr9vJyrgjxem/5u8WDQuqhKATbtmBvpQXwLj30M
         nz8bkepCjFYiPV0qCfCRlGvexr46XSw597ZWK6e6tJ1tF0tibJHIzfH+Nu0mH5qvWtlI
         If1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777041336; x=1777646136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wytk7xcJQB1xNQvFPDmiI04wJ1luZnUZ5xfDJ7i2YWg=;
        b=F8OBcppWul4KESB0oAmD2iaaSHta/UuOLpdblrHnR/LPKiHmFuMquMRuYpsuii6dd/
         BlTKB+RU8rl7/MsuajabBSAruRDZ8cOv0AVKOQE2hp8XdCKkLJ0OLsLsnp3Nv4wqfWgP
         qs6OV/4e3Oetl8NAHYy5sncQKgdosXqEjLvVkDgwXibb2Us6uj/EZ0ErQtVtmW3/1wjf
         wAa+VMBlr6W8/7PduMoqT3nCxAgLZya6kpPPKVn3K4wlWl9oPBS88FL/OIAi2pOXer7/
         p0kJs9y8HMcFDjvRcYHlLQrjwz4kS5M2RNXn+yLpcXdiK1So3F+Ydv8JyJ5OJpusdzkG
         Q+2Q==
X-Forwarded-Encrypted: i=1; AFNElJ9lQT9hS6APDmOMk5KQ20XM9uAXwBxn0UiWiNhf93n2BtxIo4EH4lrwy1J42RM45ltEQ1TUi7BEIdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpvqE9cKmWyIpX+gF8jjpxCJFWiEt9kP1U7jxgdxR9cuswItQg
	uSZiam5IGHUAvYJ3uYpQKGNCTQnsFmHHSYOS3c26iqPpFdc8FlC+3vqIcbCCf6yz9CIwSS03C7u
	XmpDgCgbOaL3rwmAEQ1oq1Njs8oOOJF8=
X-Gm-Gg: AeBDiesMRjLiyIy0I7QkbRpfbrKdpFvlF3Gpep3iLDiD+yAYXVqirf3Z1h/5/tLuXlj
	BIQOVZ8O/0z9BMzP7h4VuOsbhB/Tssc8vVE+RpLSnl4gddQRLxOuY4jBEii38Hj0r6mWli7fLu/
	ghcaU22D+LvyprXLj3ZrobeWjF64QdkpsVOupyr/Vof2mdOmXTEy2vsdRwENAh8xIyLzCoq6VyC
	WPoQTXqyNHU3fBhKECfScDFfm/EuPbNDTIFE+Z5ppqQqi+/a5rhnqeoLyklUNLCbU8O85yd6qt2
	W5/NcOgGaPAJLCj9+jeZZ+3JoICuaEwKSxtODUFQrcO7xZpK3+WZ
X-Received: by 2002:a17:907:d93:b0:bae:58eb:674c with SMTP id
 a640c23a62f3a-bae58eb6a09mr81309766b.24.1777041335826; Fri, 24 Apr 2026
 07:35:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegvVTcV89=q3L326aGQjhduBcv7PVg5QKftGLjNZmCLmaw@mail.gmail.com>
 <ad4_jFsR951c2Mtn@groves.net> <20260414185740.GA604658@frogsfrogsfrogs>
 <CAJnrk1ZgcMuwfMpT1fXvUwBBiq9eWFHWVeOFQFFKiamGGe1RJg@mail.gmail.com>
 <ad7Tps4tkNbndd9Z@groves.net> <CAJnrk1ZWVsKW2dhAWdBkCQskoTE+hmOhPFDhyz4EtExn=GdXGA@mail.gmail.com>
 <aeFDCeqZDPI3rm3s@gourry-fedora-PF4VCD3F> <CAJnrk1ad6t6CJV+xnXwhoNHrHYA3htuaVdDq47FeT60cPBzj7g@mail.gmail.com>
 <aeHXQ2EW2ivlLb_N@gourry-fedora-PF4VCD3F> <CAOQ4uxhXTTyySG3tXnqNnP0edbbwUxfeeC7=CypDSyw_Mod48A@mail.gmail.com>
 <aetxDlr0e9ILFIcg@infradead.org>
In-Reply-To: <aetxDlr0e9ILFIcg@infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 24 Apr 2026 16:35:23 +0200
X-Gm-Features: AQROBzDRfaDvwqj3ChfxGHta3IykNz6mtcAvKLit3KlwoyD0SfB9SEJdl9WFDYQ
Message-ID: <CAOQ4uxi2sb4rCR9_xTD3FFEwiPXxDG-sYzvAWqcjMQi1+Om+gQ@mail.gmail.com>
Subject: Re: [PATCH V10 00/10] famfs: port into fuse
To: Christoph Hellwig <hch@infradead.org>
Cc: Gregory Price <gourry@gourry.net>, Joanne Koong <joannelkoong@gmail.com>, 
	John Groves <John@groves.net>, "Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bernd@bsbernd.com>, John Groves <john@jagalactic.com>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>, "venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, djbw@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 3:33=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Fri, Apr 17, 2026 at 11:06:58AM +0200, Amir Goldstein wrote:
> > If this logic was to be placed in fs/iomap/ as Christoph suggested,
> > I think the rest of the UAPI issues could be sorted out.
>
> For that you don't need it in iomap, it could stay in fuse an be a
> generic striping API.  Although IMHO doing it in iomap would be a
> lot cleaner and more efficient as well.
>
> > In any case, considering the sheer amount of discussion on this thread
> > I have scheduled a cross-track FS+MM+IO for Famfs and DAX iomap.
> >
> > I wasn't going to include Storage people at first, but since Christoph
> > mentioned that stride/offset iomap could be useful for block iomap,
> > I included them as well.
>
> There is no overlap with storage.  Any use of this would have to be
> file system level striping, not stackable block driver level striping.
> And keeping the rooms smaller is a win on it's own - anyone interested
> can join anyway.
>

OK. Changed to FS+MM.

Thanks,
Amir.
