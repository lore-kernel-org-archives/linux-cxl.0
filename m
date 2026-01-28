Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96071372B3B
	for <linux-cxl@vger.kernel.org>; Wed, 28 Jan 2026 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769626481; cv=pass; b=Lk/GWPCN3HW+1klcGFE5yQ4JDpXZ6BXNtfFoVl89KSvbu3UDlLB2Ioj80uk7MdQp9u+vAIO7i263VM8v0ddXBcavxVeOSe6lMtQam8TdeNXUXncNYKucVIdWsf8PzBs9MeHN3k6qRlYQFCpEjQSnSs2gOMNusTRJQqjR7hiahmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769626481; c=relaxed/simple;
	bh=Iv/R1VrCmh7DPMnIVbKr+xqiK5DjA15w78PbjXQO200=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jfHraDtvhYQuuhwHnaMBbZXbh6Uoq8LNLwUzI9XvZWePEiiQR0e340WxI5PirHqUfcx+RREGQ/VQMeT2EXpjetQGawJrDJ3xIjCmnmbnA+AHhDvuJIcpGiS9yqPgwU0E1d3uaoxVpytCdhtH3U5djyes5qZtYDL51GQN7sJwMBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMqWeIwI; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMqWeIwI"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-501506f448bso789311cf.3
        for <linux-cxl@vger.kernel.org>; Wed, 28 Jan 2026 10:54:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769626479; cv=none;
        d=google.com; s=arc-20240605;
        b=CAqqaY8WLRzC4RjpV0EXrEU/zlod9bQxIP9wBIim1ykXR6mdEwsZoL6peHKEuCEW6c
         SeXT++L5JjJW7tLgQ9NdctyNkpJ+2BGk+clWkskZiUgxsDtMfnznQHgEexPUyw/vdvZK
         GDC2E6h+9LBvq3CaS/ppH5nFVIOrEP/x9K+fjUoo7W/95MExqIj5eD/ZsgwWpnailUfp
         a1Z/n12wdau8TwVEpfyUHR6Yk9IKUzvaBgbNdlNMXJsitPvSYsTCq8IMfRxdwB1p9X83
         bbMhFbQ6v7MCcCs7labAehO2DWwEJ7sFQCUjHjGu1DWsnhHRA09OUFV1Uy0wdWK9cPGz
         GVUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EQD+zhNe2TBSVN4C+gGjdPZJybKoBQIJM5cDvqByP90=;
        fh=SHUL5BfcONqzOWZpOFHn9FpHQ8fUyre12YpHpkv+790=;
        b=HGfL76kxAVA5pIpzv/JnGuRwmWkTk54LYT5HCwg+CR52ud6AO6S7snzxePfkGE114e
         vO8PJn/OFTk/X2RYBeGFnZGwYG+M8TmoKKt1mVWpvXIJbW3s5k9G8GZdUDVFc8XHnhhA
         JsepOXb8VldYNfbIfc+30U7fwG2i3iOaodb2v7guaxavx+hD6Mi21qPTm0XZq4OYTnwT
         AqlS/jpqPYVxU3jqN/tLVOmPIjoXMLWrRkYHm1yPu3CxadZFSjHafpIipM/kU+w0UO2H
         XBZfuYZQSxOzHMOBZr3Pm27UJHvputb1Halj7zkyaPIz/lg4R/PpxImk+XSHHhF4g8ql
         z3ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769626479; x=1770231279; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQD+zhNe2TBSVN4C+gGjdPZJybKoBQIJM5cDvqByP90=;
        b=nMqWeIwIAlKYcQIFhefA7zNtavrmv2uZ1Rq3jpT/gQrF4rV7DhVyyMlHiMWHWjMLBC
         dkXaLYPg57lLfsY3ZY8e0H8v4bvI/UCaEew+WU/YHJQuVZF5765U3AN+toFuivAuYhYy
         yblY7vDQ50Q4nsFIpY9Mto3Ehw0CGGg1kQwpiyJp73rAHafr+u4GfnCSYTsAxeA9bZPE
         dN2GVo80uQViIUaIyHRJPeoMblJGhyzc6DmkWyFCXcXY1PjPTOH26nV3AokrrDa5y679
         oE5oj4IfSJ65MBZ1Y2iPt/1OrlufxJRgRk13ygoW1CzpqiV07uTW5U+vrfgsIbits/cX
         StSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769626479; x=1770231279;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EQD+zhNe2TBSVN4C+gGjdPZJybKoBQIJM5cDvqByP90=;
        b=xFAdGULLz3RxPIOOQnHOldXH3G93zk//M3Mo1KrRD11/RTl0ap1F3dnt46r6Fq5WRW
         oh6uEvUaprqqg7T7QBiuJ8Uo7wTH73GZfzUEQX6JceEU8Tpxa1bjXdoVHlXeapm7wZR3
         fgrUXc9eBR+1SkicWs55Sc3mTlyVXaYPKkCMHo+X9NkPnZJh2fZ/t01omwKNR+GUcpTO
         JZWxgHs1Xsea5Z0OLA5oZB8KsRPhGsdlpVJf1XI8uTCxnpwRc1mgldH7VutAqT2b6Zm7
         23OFxYm8Ch0HvX2vSxCZCdCn1E7REMLo2+u4zzHEDlPS5U2wa3hSrHc4OEriGL3BSUYy
         DCrg==
X-Forwarded-Encrypted: i=1; AJvYcCXxKXQFqQFiKFmYGC8Z2nkMq88ZdRb3/5OOgckcbbahX7J/ca13CiOjtCTgpEjQ1Z24/OcloeMYeAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgqM+0VJ1n10QOFLlAGxN9eKks6p5wO0uBzcOyA+KPv8zcPpA5
	2i3aDIO21uQliCnuHpvxYGQ9ixbfkMPY1VkDTUgDZp6bHccrlRz8qY2pgMsZNUuZrb5j5JHikB1
	SY11JFcxhGc8eLt52iZD/pXWsQFb7EtM=
X-Gm-Gg: AZuq6aK9qwXsI9sck35H3z4+eIoqTWRKHexKRbdqxTEaqzlycFt4obZil3khK5B0G5Y
	yU2BdiTfHBGrXxPl0JSC9rvNCyN5CzlmMozp7fdpY6atKUx89QzxddRsxj6SycY8hKQQA8qL9Vp
	ylBGkkkELJemXltZ6FWavq92SvDPsuLUbmgJcJRkADvq2awXMPx/uL9JmucSmk9l8X3lWoS0Fh3
	zZEZJ7Ha26Bz9ZhW1osREHPQCTHPPWvrqpE2nlOUJcMZyC+YLJ23AvPK1VILp6tk7vOjg==
X-Received: by 2002:a05:622a:1b91:b0:502:9b1f:ca4f with SMTP id
 d75a77b69052e-5032fc14d15mr83239651cf.84.1769626478464; Wed, 28 Jan 2026
 10:54:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260116125831.953.compound@groves.net> <20260116185911.1005-10-john@jagalactic.com>
 <20260116185911.1005-1-john@jagalactic.com> <0100019bc831c807-bc90f4c0-d112-4c14-be08-d16839a7bcb6-000000@email.amazonses.com>
 <aXoarMgfbL6rh6xi@groves.net> <CAJnrk1bvomN7_MZOO8hwf85qLztZys4LfCjfcs_ZUq8+YBk5Wg@mail.gmail.com>
 <0100019c05067b3b-b9ab2963-ace5-481f-8969-c11f80a74423-000000@email.amazonses.com>
In-Reply-To: <0100019c05067b3b-b9ab2963-ace5-481f-8969-c11f80a74423-000000@email.amazonses.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 28 Jan 2026 10:54:26 -0800
X-Gm-Features: AZwV_QgXH_eGEFbh8Ufwurz5i77r71GDNcEX490YVb0oLl5TmaOznNxDkpKSA1U
Message-ID: <CAJnrk1Y6HayeS-C3sOEOc_CgaS_K=SedZNpHASAXAkgZyp3Xsg@mail.gmail.com>
Subject: Re: [PATCH V5 09/19] famfs_fuse: magic.h: Add famfs magic numbers
To: john@groves.net
Cc: Miklos Szeredi <miklos@szeredi.hu>, Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>, 
	John Groves <jgroves@micron.com>, John Groves <jgroves@fastmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, James Morse <james.morse@arm.com>, 
	Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 6:33=E2=80=AFAM John Groves <john@jagalactic.com> w=
rote:
>
> On 26/01/27 01:55PM, Joanne Koong wrote:
> > On Fri, Jan 16, 2026 at 11:52=E2=80=AFAM John Groves <john@jagalactic.c=
om> wrote:
> > >
> > > From: John Groves <john@groves.net>
> > >
> > > Famfs distinguishes between its on-media and in-memory superblocks. T=
his
> > > reserves the numbers, but they are only used by the user space
> > > components of famfs.
> > >
> > > Signed-off-by: John Groves <john@groves.net>
> > > ---
> > >  include/uapi/linux/magic.h | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
> > > index 638ca21b7a90..712b097bf2a5 100644
> > > --- a/include/uapi/linux/magic.h
> > > +++ b/include/uapi/linux/magic.h
> > > @@ -38,6 +38,8 @@
> > >  #define OVERLAYFS_SUPER_MAGIC  0x794c7630
> > >  #define FUSE_SUPER_MAGIC       0x65735546
> > >  #define BCACHEFS_SUPER_MAGIC   0xca451a4e
> > > +#define FAMFS_SUPER_MAGIC      0x87b282ff
> > > +#define FAMFS_STATFS_MAGIC      0x87b282fd
> >
> > Could you explain why this needs to be added to uapi? If they are used
> > only by userspace, does it make more sense for these constants to live
> > in the userspace code instead?
> >
> > Thanks,
> > Joanne
>
> Hi Joanne,
>
> I think this is where it belongs; one function of uapi/linux/magic.h is a=
s
> a "registry" of magic numbers, which do need to be unique because they're
> the first step of recognizing what is on a device.
>
> This is a well-established ecosystem with block devices. Blkid / libblkid
> scan block devices and keep a database of what devices exist and what
> appears to be on them. When one adds a magic number that applies to block
> devices, one sends a patch to util-linux (where blkid lives) to add abili=
ty
> to recognize your media format (which IIRC includes the second recognitio=
n
> step - if the magic # matches, verify the superblock checksum).
>
> For character dax devices the ecosystem isn't really there yet, but the
> pattern is the same - and still makes sense.
>
> Also, 2 years ago in the very first public famfs patch set (pre-fuse),
> Christian Brauner told me they belong here [1].

Hi John,

Thanks for the context. I was under the impression include/uapi/ was
only for constants the kernel exposes as part of its ABI. If I'm
understanding it correctly, FAMFS_SUPER_MAGIC is used purely as an
on-disk format marker for identification by userspace tools. Why
doesn't having the magic number defined in the equivalent of
blkid/libblkid for dax devices and defined/used in the famfs
server-side implementation suffice for that purpose? I'm asking in
part because it seems like a slippery slope to me where any fuse
server could make the same argument in the future that their magic
constant should be added to uapi.

For Christian's comment, my understanding was that with the pre-fuse
patchset, it did need to be in uapi because the kernel explicitly set
sb->s_magic to it, but with famfs now going through fuse, sb->s_magic
uses FUSE_SUPER_MAGIC.

Thanks,
Joanne

>
> But if the consensus happens to have moved since then, NP...
>
> Regards,
> John
>
> [1] https://lore.kernel.org/linux-fsdevel/20240227-kiesgrube-couch-77ee2f=
6917c7@brauner/
>
>
