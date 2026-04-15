Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46AD3E5564
	for <linux-cxl@vger.kernel.org>; Wed, 15 Apr 2026 17:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776273189; cv=pass; b=pU+8eMsTvFulNGnB/x+hQfkM8h98/NPk3B4fXIaD1HNiUimGlKttDg61BxiXVwd86wZFO+fLD3yltUSTj+0oJzyHwHvgiVn6R+G1FXiw6AHN1EF/A8kS5IiWnmE2xNhCEuRxpIZw+JHTtuyjukhAygvp//GSOGu1PMGELN1Em+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776273189; c=relaxed/simple;
	bh=wdhiL7zirIut6Om162VyHe/8jfVFe22PxHmav53dlqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AXU2BQCy5lpu9NzOk/0lVvoruU1EMQI69SPbM3Q8qQEam/1pUI+sIOUpPXl5br/OD4r+Bvna/8YjZQx5nirM10+VVHBYcXnHdLe0/6hrXb3WDANEEZYGCEMFcMV04/bfa/XY4uFmtuDdp5Ykqo8aS6xJJiTrJKuKGPm8mf4NapQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sjd3jeZl; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sjd3jeZl"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-43eb012ac4fso217968f8f.0
        for <linux-cxl@vger.kernel.org>; Wed, 15 Apr 2026 10:13:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776273186; cv=none;
        d=google.com; s=arc-20240605;
        b=h4OhhjKBs1AVYGFZKkbDSRNWs2YtPeOeb6J4MhlhNPlgW6sU6xG43LbL73MxEsreVj
         zNvDkQpt2HjUoQe22HJx3aEkrPJ1GckGJp+RbxxxdTRF+ycbuEz4Niltfv0+9X5dNDUM
         T6P+oukvi7wuyo3nTgKkRpn9Qn4ic6pZg+X+BDol2OsyQO24TCWrQswQEaZeB8fj1bwP
         Pi0pdYRcFlfVYSO7X+6UdcSOkN2Mg8BWHwWzMtyRl9KWc3JX08cfhuy2Ua+TJngxJ6Wp
         yDROwte5RUKoyebCeQilho+BhU/ltnFrosZ+kxoJYsbTTzO+2AyXEtcbO1oWaa37owtz
         exOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lw/2t1b75/Yh/hGij9+OEBMIfvViI08SLiP+FJ468hQ=;
        fh=/zw/FAXkiPv4GAdSz+YF7B3Yl/b/Uq7kfdX3VWKb/1w=;
        b=OS/63f/V3eKiWyIsfx4CFqiLjtrDRfpi97/7rRCqUkJcFjv6CPehvUNu4n33pe+aNW
         651vxm/zrnM+3oWj1CPy/q/4/BbFYLfaDGtTkmPUCHSQeFP7cDM4g12wkhfvDZqQyr+q
         JF8Xk1l5Uhjq2nEeTNGNtnKZvB3pamHH9CN7PDMuJ+lVS1Uy62+J5gXSL41/fK5A5GEA
         JCgqkshXqohJEO2d+cVn5GJgthlgdPHHe4vMUJcXj0UrsKslW1PS7/ryMDBtjbyBKkS3
         Yjp9N/QxmQjt8GJwwJ4rdTm/iHoqgOxeZoXz/+NdnNJQ+65zhLF1Sp0JmQ/vPfYwDUMx
         OI6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776273186; x=1776877986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lw/2t1b75/Yh/hGij9+OEBMIfvViI08SLiP+FJ468hQ=;
        b=Sjd3jeZl6y4erdjEHWhwMwBlGkfCpssIZA1lQqG8otVlIm8H+0jXvd8/PrrfVW9mgE
         4b+aXZ3tscCnZzN5xFX9RSrg5WKO/Hj34QUfAOTopi1Ghb2TOSbESPzLLDCRqqQevTzL
         23khlWTfYpSTPcyVJ93xMIiABXTI1vh0/u2y4j6P71dP21+1ZUZqBSBGiEeGrGaCL+ly
         3eTL+TZvb/1VKT7Ml8mtEtQ7XmHC002tV+oAiuJr8GOEQUgNhP/URKwprnyhoaffnaY0
         GSehVFeeIWcGfBVdSs7JilO67Nna89mOYZO3RyfYRdHMBi/OEI3l7ZWmGH1xBfKDUzpi
         3tSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776273186; x=1776877986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lw/2t1b75/Yh/hGij9+OEBMIfvViI08SLiP+FJ468hQ=;
        b=MinC9/w/m8WxO2w2xx5EfUFagEIKyptfeEhed+YxGFhmAMzBx3HcL16PXW2+7E4iBr
         vCWZ39ex1lfx3Q6u7wzoZGKYXjPB/1sNTeEYta6icQ3JKkb/Hcarok8FETzwivkxYrkF
         bj0GAPY2p3YX7N6dJExuAkdPFT39vfJ5C3dW356SxPJEaYIiFoqQXiUQcZD3sZSq0aDW
         KSyLLozd8r1RqkpMJBVZYEHh0bMHx2lPFAN4FbFdmgk20joZI7z2oLojfIgCLzGQyEkm
         gy9g3XxaO6vjDjJ0pwOyQogDHaa+ruTutE4xXE7jNx3sQKoBLYKRE+MSW/MXMB7yE6UB
         stHQ==
X-Forwarded-Encrypted: i=1; AFNElJ+3nrCUs24D5o9qKD0GV4826JZSFiIuz7Xobu2vI45d49330gepKmAc3iCjakusYqmfve06acChBlE=@vger.kernel.org
X-Gm-Message-State: AOJu0YytFIMG7ioFE/M0lhQ2jRjBhACu0iWD7sSc2EqE/LjQGXNWCskr
	Q1isYnPZN7gHumsUXE3cZPISRslaz2K17LTJG6+Daqx2LUoF1iZkr3ZtcKCv5Slqas5cVxaNF/8
	XFHBfDwF+cwxM3GWDwU8Lo+y2hV60bsA=
X-Gm-Gg: AeBDieuPq72SxIE2GIC060+aDJ0+EcJa6PVIF/3T/igkJX1YU6kPgmRGiwk+mk4UyvA
	8ByTe8xO/+XKlj7AqjpV2TIrK/2KHf6eR32ltCRxLmfF33F6LUnIzfuxnLgr4bgzE22xOsP2nBx
	NNqKaVbEh5DrijT3Ev7+EMnuPhucG1WnrcXu+6rX2dDOcDwLoRaPFwZ21ZWufxUSclmgKnn7FdT
	qINBGhcCNswgJiXpdSpfPAO0d1Ru9PT6E5+ra5HvbKJzzo3PpsgUDqrFiASHhAkgHCbhoW4QrRT
	ql5pK/smRm+X6ZtI
X-Received: by 2002:a05:6000:612:b0:43e:a81d:c475 with SMTP id
 ffacd0b85a97d-43ea81dc4d7mr10552860f8f.6.1776273185949; Wed, 15 Apr 2026
 10:13:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adlBcwJjLOQDAR65@groves.net> <CAJnrk1a06zkUmXW5EFiUmgAoFauwtzsYvnotaPH0ifVtyh7iDQ@mail.gmail.com>
 <CAJfpegvVTcV89=q3L326aGQjhduBcv7PVg5QKftGLjNZmCLmaw@mail.gmail.com>
 <ad4_jFsR951c2Mtn@groves.net> <20260414185740.GA604658@frogsfrogsfrogs>
 <ad69tTnx5YkD4Y9K@gourry-fedora-PF4VCD3F> <f254f6fc-dc06-4612-82d7-35bb10dbd32e@kernel.org>
 <ad-UAMcALRubBcHk@gourry-fedora-PF4VCD3F> <CAJfpegsUVv0ziMSQiq9pKeXf6G-+LROPTW077hHMSmAirVCLQw@mail.gmail.com>
 <ad-qSB4oL5D3S-ht@casper.infradead.org> <ad-vnqRrUGs9n0N8@gourry-fedora-PF4VCD3F>
In-Reply-To: <ad-vnqRrUGs9n0N8@gourry-fedora-PF4VCD3F>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 15 Apr 2026 10:12:54 -0700
X-Gm-Features: AQROBzBkUIPEeKz-diD1-ugS7vjNoU9GOhppKCAHhyQ-ncyX3_eObS7SHF41aIs
Message-ID: <CAJnrk1Z+uNjn+BcmpciqPZhxYXEJ5Zgh=uNCxt17WTkdOubbog@mail.gmail.com>
Subject: Re: [PATCH V10 00/10] famfs: port into fuse
To: Gregory Price <gourry@gourry.net>
Cc: Matthew Wilcox <willy@infradead.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, John Groves <John@groves.net>, 
	Bernd Schubert <bernd@bsbernd.com>, John Groves <john@jagalactic.com>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
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

On Wed, Apr 15, 2026 at 8:32=E2=80=AFAM Gregory Price <gourry@gourry.net> w=
rote:
>
> On Wed, Apr 15, 2026 at 04:10:00PM +0100, Matthew Wilcox wrote:
> > On Wed, Apr 15, 2026 at 04:04:50PM +0200, Miklos Szeredi wrote:
> > > On Wed, 15 Apr 2026 at 15:35, Gregory Price <gourry@gourry.net> wrote=
:
> > >
> > > > This was my first reaction when I realized the BPF program would be
> > > > controlling iomap return value in the fault path.  Big ol' (!)  pop=
ped
> > > > up over my head.
> > >
> > > I'm wondering which part of this triggers the big (!).
> > >
> > > BPF program being run in the fault path?
> > >
> > > Or that the return value from the BPF function is used as iomap?
> > >
> > > Or something else?
> >
> > If a BPF program controls what memory address a fault now allows access
> > to, who validates that this is a memory address within the purview of
> > the BPF program, and not, say, the address of the kernel page tables?
> >
> > (I have done no looking to determine if this is already considered)
>
> From an initial look at the existing bpf ops structures, I do not see
> any other struct with a similar (obvious) pattern - so it's not clear to
> me such a concern has been exposed elsewhere or directly addressed.
>
> There is a verifier step for the BPF program that in theory would
> validate the range matches the DAX ranges, but i think that only
> validates the types are right and only on load - I think the BPF
> program itself would be the address validater, which is a strong no.
>
> BPF folks please correct me if i'm off base here.
>
> My initial take is that it's a real concern a "bug" in a BPF program
> could let userland map arbitrary memory into userland page tables, and
> such an extension would not be a quick fix to the FAMFS problem.

If you're concerned about arbitrary addresses in the bpf path, you
should be equally concerned about the FUSE_GET_FMAP path that's in
this series, because they're functionally identical. The kernel trusts
userspace-provided addresses in both cases. If that's acceptable for
this series then it's acceptable for bpf too. You can't reject bpf on
security grounds without also rejecting the current approach.

Please take a look at the famfs bpf program [1] and compare that to
the logic in patch 6 in this series [2]. In both cases, iomap->addr
gets set to the address that was earlier specified by the userspace
famfs server. In the non-bpf path, the userspace server passes this
address through a FUSE_GET_FMAP request. In the bpf path, the
userspace server passes this address by updating the bpf hashmap from
userspace. There is no functional difference. Also btw, this is one of
the cases that I was referring to about the bpf path being more
helpful - in the bpf path, we avoid having to add a FUSE_FMAP opcode
to fuse (which will be used by no other server) and famfs gets to skip
2 extra context-switches that the FUSE_FMAP path otherwise entails.

As I understand it, famfs is gated behind CAP_SYS_RAWIO, which is a
highly privileged capability. To use iomap bpf, this would also
require similar high privileges.

Thanks,
Joanne

[1] https://github.com/joannekoong/libfuse/blob/444fa27fa9fd2118a0dc3329331=
97faf9bbf25aa/example/famfs.bpf.c
[2] https://lore.kernel.org/linux-fsdevel/0100019d43e79794-0eadcf5e-b659-43=
f7-8fdc-dec9f4ccce14-000000@email.amazonses.com/

>
> ~Gregory
