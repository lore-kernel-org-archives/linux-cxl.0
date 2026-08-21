Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7060240860D
	for <linux-cxl@vger.kernel.org>; Fri, 21 Aug 2026 19:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341181; cv=pass; b=R+LchzWNjU12QboFTEJFRVbrTT/s6cKuSHamgJHn2S1IkAO9lfweoXAiSDYCc5NA+9ZbQ0qFMYxz+qedFW3AuMWyyE7hIbvkWE7fn7d52iR8QynlcNPPkqJduP20CEEQ+ZPxypMXuwJiCzh/lnMe/KHV7w39cxejQs3mdcZ81Gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341181; c=relaxed/simple;
	bh=2QaAsriM6IS3lTgDPUOF48nwqc8aTC29sa5P2y66CZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvFO/YyjcvD1ReQcRJqU+eP5mwBZ14D1nt+GhIOTVYLUoLXrzhKxSS0bTr3NfYOT+MSMwRLHcvgxdmF9qo/SsOtIgVWJicfIk/bF57iOi0hnuPB1H/sJEzRRuYVpveh/sUEKXc0WV9YTAneo8Ah3opuWQpzc1VdGZfjFzdblkvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ntRi3l6f; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ntRi3l6f"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-529a1ee0e62so9575181cf.2
        for <linux-cxl@vger.kernel.org>; Fri, 21 Aug 2026 12:39:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787341178; cv=none;
        d=google.com; s=arc-20260327;
        b=PTkTzKnS+tUcV3BXYsBdhxMOm7Ik/lz6QNmxf2zHYvFwO7DhoEDqaJpOvXf8sHQ1qX
         dQ4ULZqpuATFSOdyecS/YZCv7UF8m0p+PeGQDP7Ly3JvuugmcBvOX1OHaKcH2TCBt45x
         anJkmCuYwA71F1RyPJo3XyO7rQtCwEVDb0nQhlR1Dj6Ti/QVbFtTnkyq+bXFn7UFyhPF
         33WiX7BFO/OEwwH+/8psYDYWJSf8AXWKuOJMszSkzLlRtCxrK26iRf6X3riDu7H924EO
         Y7TAdN28ips6lvDrb2jyfd4tk2k8BNkzkXspQefYpJaDP9Ubqk4/eUDMyN9OkSjHVKv+
         iKvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KUV4QsUdOhj/C4gedxjcRezZM90WK5l233fM+QINPEo=;
        fh=1LFFOKfsyWrCN+vsji16nRudA3DJBke7bWQZRjq2zVI=;
        b=FA9av3zbFc+OJwAw612RdAgnM/2wFJHlm4TSOgGhHEexax2op8co2KYmjbr5o6wN+0
         b4aULwymNCGIW7hRr2qCTIkwKfr2xpjhUJL9OsxU27PZZDV6IJAHxNa1LcodJwnytEJM
         i8iTT3GEjRd7JJChiZo8gRotBNfHN1z6HDSvujRU7VZBwYecHb2D5wlrHVYyYowOvYgB
         2sTronc+grRH/uQwWCwraOctRTixm4nfRTav8GttyXZC6Ib8Eq8RF0m5/eLaL/5cH1oU
         NS0EiZwBiHMxDW7gqK/FrPQVcmdm7ta09646MLpNqGOZG1pWrkXl9/CMEc5Fh00Jp9sC
         Nv3Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787341178; x=1787945978; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KUV4QsUdOhj/C4gedxjcRezZM90WK5l233fM+QINPEo=;
        b=ntRi3l6fuSV9/6tG2fuYlr7KOGFjHLWC/IgW2qf4q3GpWubqv3EwQ7RyHdfc8ip+bC
         BDtWmCiJmttrako1jPZQNWy5Jaqm4OO197ZG2Rd93WJZYtJjQ7TA9wN/jYOZEeWm9gF0
         Ic5xTwX5EPosMMv4rEDJxzTHyYNoRBavvuNXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787341178; x=1787945978;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KUV4QsUdOhj/C4gedxjcRezZM90WK5l233fM+QINPEo=;
        b=CYDQ1bjT2aTL6/TCI/+IE6a6ry1eb9inhtBVHshWPT657/1k7mKtK4Kx02QsXhy6Ab
         XtD9TDGfVo27wMhULpWwMPlyrx4A++RHK3LfLW35TDQKXX+53k2lY2KGh9MRNye1e2jn
         vPhXz8lDXFsz4KHIzK3/fFAzPMQkrYSdjKbdOsjmNE3wnD3E3zsLmpOFKnlq0Bisgnnx
         V1hoQFIqg7oqyyXKtcAHD5v6cQT7kMCaHqhDaW8MGg2N3EBwFBEpGYVrh+ygqtyFHUdz
         pJW6dMX8IcbbLgAnXibwQjYBpJsg3hEGfPmOg+nUb6FEasfl5IOh4Z5ZD0lTvi+7eWEY
         s6pA==
X-Forwarded-Encrypted: i=1; AHgh+Ro20818hqaRl++TXr7HuJ6IlwBTlomPPflnfou9myzJdfsXbEPC29xn2+tLhEw1xvMBQB7dJlGe+Zs=@vger.kernel.org
X-Gm-Message-State: AFuF++mUqhhx01kW4W+rc/9/G/rwrPULNJYYhvOpiof1+5WX+yeQQL8A
	8T/XeoUc3ajMUgHPF1BmVbdxR8zxajwRdbzWWKZMapgZnFJ67VV35WJd5bc7GhbfEiTwgZtR440
	ft8GJ4CUR/maFmWm4+5gXa1htjfdrikuVVLiwxcEJjA==
X-Gm-Gg: AR+sD134D+FyD+6CMHRDZwxSPG7YVHuiClOQSlcbUQ3BUYB4SmUZEKJNyC2CtXfm6ct
	ZiNWa+NGuGSnozv9vm8T7nNmi4V+SuNc5YLQNJSmi1LlwF0WSVLH2LONSbvMma20kC011gRT74I
	gK3yruPuRvruHw7NxF0BO5qwyDyCCYrn7dVRGtn6J++YVCY3rvFbxzuUiwEKZNWC94kuK13CI+Y
	7M/9ZOFMnWSbtW83UrnWqKuTE1en2n5F0C8EhONGdF0JK+iHkTM51ghe2tu2Ceab0HoImUrqV48
	KSnSPe2GG7mNJkR6Fr79Ahrht6sLJeeUNlaWC7Y39NiT2+VmHZjjielRer+eEc8q+jh9PQZ7ESH
	1AYM59Lnk7PFJAXmknAlxHPDYiP4kqeRO
X-Received: by 2002:a05:622a:1f8a:b0:51c:1532:ae93 with SMTP id
 d75a77b69052e-52df5a32867mr88198341cf.26.1787341177980; Fri, 21 Aug 2026
 12:39:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0100019fc572ca94-ec363dd7-3a77-484b-b4b7-f2503a0931a6-000000@email.amazonses.com>
 <20260803022828.75776-1-john@jagalactic.com> <0100019fc5739e5d-bc002300-eede-4c40-9ca8-a277b754496e-000000@email.amazonses.com>
 <20260806043712.GB3560084@frogsfrogsfrogs> <CAJfpegtW4bFn=oNfTipCxhiExaqSXnhXeBd6Uq15FpepqCJaPQ@mail.gmail.com>
 <20260811-baugebiet-hofiert-fanden-3354f4a5e820@brauner> <ab642f3a-e377-4292-b2ff-bc970f5384e8@kernel.org>
In-Reply-To: <ab642f3a-e377-4292-b2ff-bc970f5384e8@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 21 Aug 2026 21:39:26 +0200
X-Gm-Features: AcwNN1V5lCcm6_l8LY5VakD6tTocDvE06I1hYgFmfavubxTv285rgBmrPN7M8XY
Message-ID: <CAJfpegsC-D0AJij3E=dbKzZCH0nijE7+rpPut-EnRd3r0uCMtg@mail.gmail.com>
Subject: Re: [PATCH V12 02/12] famfs: Module operations, fs_context, and mount
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, 
	John Groves <john@jagalactic.com>, John Groves <John@groves.net>, Dan Williams <djbw@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, Jake Edge <jake@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
	Jonathan Cameron <jic23@kernel.org>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Andrew Morton <akpm@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Ira Weiny <iweiny@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Haren Myneni <haren@linux.ibm.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Ethan Nelson-Moore <enelsonmoore@gmail.com>, Gabriel Whigham <gabewhigham@gmail.com>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"fuse-devel@lists.linux.dev" <fuse-devel@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Aug 2026 at 13:40, David Hildenbrand (Arm) <david@kernel.org> wrote:

> (a) Whether a fuse-based approach is feasible.
>
>     Are there any major blockers remaining?

No.

> (b) Whether a fuse-based approach is inefficient.
>
>     Are there scenarios remaining where performance or metadata overhead would
>     be bad without an easy way to improve the situation?

Lookups can be cached, extent mappings can also be cached.   After the
inode is in cache and the mapping is set up zero requests are needed
for open/mmap/read/write/close.

> (c) Whether a fuse-based approach is a bad conceptual fit.
>
>     Will fuse have to carry a lot of famfs special sauce that cannot
>     really be used elsewhere / generalized?

None.

But "can" and "will" are not the same.  The striping code might not be
very useful outside of famfs.

> (d) Whether a fuse-based approach is too invasive.
>
>     Will fuse extensions to support famfs actually make it harder to maintain or
>     slower on some paths?

No.

> (e) Whether a fuse-based approach will make famfs harder to extend.
>
>     Is there known follow-up work that will be hard/impossible to model in fuse?

It would actually make famfs much easier to extend, since the
directory structure, metadata, etc. is now controllable within the
userspace server.

> (f) Whether a fuse-based approach will reduce maintenance effor
>
>     Will maintaining fuse extensions possibly be harder than maintaining
>     standalone famfs?

Testing is a key point.  Famfs needs special hardware or emulation, so
it's not straightforward to test.  This could be solved by adding a
"dummy" mode to famfs server that exercises the same fuse API, but
instead of special hardware would just use plain memory.

> (g) Whether a fuse-based approach would make famfs more complex.
>
>     Will the shift to user space result in a significantly more complicated
>     overall solution that must be maintained?

The server would be somewhat more complex, since it's now implementing
things like pathname lookup, etc.  But the other stuff (managing file
maps) should be very similar.

> (h) Who would help drive the fuse approach?
>
>     Fuse people seem to be willing to help, but I expect that there must be a
>     close cooperation with John to make this fly. I don't expect that John
>     himself can easily (or understandably wants to :) ) do the heavy fuse
>     lifting.

Yes, this is where previous efforts seem to have gone off the rails.
So I agree to take responsibility for implementing the kernel side and
help with the server side on the condition that John has trust in
this.   I'm not promising -7.4, but can at least try.

Without John's trust I'm not taking this on.

> (i) Who would maintain any famfs fuse extensions and own any bugs?
>
>     famfs will possibly depend on fuse extensions that might initially only be
>     used by famfs. Would the fuse maintainers just naturally deal with that?

I can take responsibility for the fuse kernel bits.

> (j) Whether a fuse-based approach has an end in sight.
>
>     famfs goes back .... quite a long time. It would be nice to close that
>     chapter :)
>
>     Is there an end in sight, or could we end up in the same situation in 6m/1y/
>     ...
>
>     IOW, is there a way to agree on an MVP that won't require a lot of further
>     re-planning and changes to a fuse-based design?

I already sent patches to implement the dax dev mapping, and the
striping.  We've discussed adding support for fixed backing ID, which
was something that John asked for.  The only missing piece was adding
a protocol extension to set up  simple extent mappings, which already
existed in the famfs_fuse patch, just needed to be renamed and unused
fields changed to "spare".

We (Amir, Joanne, me) explained to John how this is exactly what's
needed to make famfs work.  We've not seen an acceptance of that yet.

From my PoV this would be extra work, but in the longer term would
expect to be less overall maintenance work and fuse would gain some
useful features in the process.

Thanks,
Miklos
