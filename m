Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BF748CD4A
	for <linux-cxl@vger.kernel.org>; Tue, 25 Aug 2026 22:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787696109; cv=none; b=SGQNH0vdOwTghWtxLAEBWiu/JkCcIB45uHJ9pQJ5Ty+NjUKYvHTqHDK5MA7mS0jBqMRbLhR4uV/0iMcXG6xBeQcXCReIFsxopNR2FfT2gB/UC0VGNgJBYbq7Kl7EgfYBfoPsFdLMQnXhcGzQKzlQlZ569wjUrOhp2w0jATikpAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787696109; c=relaxed/simple;
	bh=ALvTtQS/ZvvUR9gxm8qmzRxg51/e/os61XAFTpQzc/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZI9fhanjiu4R7FRZMwA4VyRuScDRBawGVBQ7AQMXTOYt9JsxcgpcWnVdNWm4plj6rSxMovwbyRZSuKzLwKMceSO8eU272wJQwKiKOhZR686xBBXWZFzSbWVjrYIs1uUOZKxGaNboPS+GpIEvKmgM6DLTjH6gddpW2Qxg5Lob3iA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-97c940ef65cso152468241.2
        for <linux-cxl@vger.kernel.org>; Tue, 25 Aug 2026 15:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787696106; x=1788300906;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ALvTtQS/ZvvUR9gxm8qmzRxg51/e/os61XAFTpQzc/U=;
        b=kX2U8TslVoPEg1yCfZDhMmrocY7bRdluE2m2pOXFRVSJaL+paDQIMKSeSpDXbOteON
         2vmTTzCwhC8ydseUoD+xEJR77lCLJlBacLtolVyeA8QsosYdkRMzKOFMxm1WZWR93bwM
         BOW+PDPN7z7xuUI4ofPo2GuEL87qV7oHkGNGMkMsNdfSin8+KiUuYOM/hSNaXbFmdkI9
         IgcG6Ouwm7NMVtw49Oil1CTg0I3WEOSaRThVoKkZtwz/7crKjhpdZNIWb/CKqXfShaA6
         NXdbAfOwCMSu7jAy8MCK+0eawrxCQoIBOyJp5UovaxhyKB2BUnRY3MAYVFO60UWS81c5
         urgQ==
X-Forwarded-Encrypted: i=1; AHgh+RrKqvBxP5KbzHXpRsu9zk5+ilTMrli8YbXTH25k3o5tTo6wPgkn84glNmYBwTA7ZmqKsz9ip3X2RAk=@vger.kernel.org
X-Gm-Message-State: AFuF++m9LqVchOSvb5Y3MdEivEZS5QwQbckNZT0fdZOQgIlcicnGvt4R
	FGr6xhjHkE0YtE9EoaduN8bMK0K7bDSnFJgFPWU4hFfzfeP9mx7ooMEMabKjOKyv
X-Gm-Gg: AR+sD12KqzHB/QpTEtC1b7KfyhGYL5hS287jHrqKKZ8sAcvig3z3/3VJmd+9h0gtRTl
	LhTPcS9Y9MiYdFodyrh962Cbu+PTWnd1RtVytS8whJ1rYHI9+Q6V400M9VanCgPOZM7c67reIlt
	mbnllsnqbH0VLAtZRTUfLr30K43nR8TO61IBntexfeWWpdq1DX3kuHtlLznySQGQuoj4nWlZCwz
	QNAYEihRKV1xj5Qkw3r+dLENsPAWj0LjghoP8MKcKYyfNuGod4NR6VGUEiD+6k8n62L1+LfTyVU
	JYfoTjrv88ll/c6ljr1iss0OE9msYr6hYrFYpJUSo8XYWGeBaEwv33js3QJajsSi+NI0b68JHxe
	9K1v534WB8s40NK2MOHnREp15OhGAJz8ohmq5OYZ5dMqh7WbR6IdNkGi8VdDtxC7rYJEt58f7ZV
	3MExMIrQrVWJDs0gSgESygOznQvDztWiuWOPDMYcGdhVM1Zx/bhq0We+nxSWPid8bm8gjZlLxNC
	h6ZOVUu+Te9MScO2gIB3MG2TnIk49/j3niGwQMNUGZG5JbjHyjU2aDW+W+BbDXoP8wwrOrx4HyT
	tRH9Uvn5SXqCsZpDGaf74JCB/g06Uk6y79o=
X-Received: by 2002:a05:6102:3a09:b0:77f:f475:2037 with SMTP id ada2fe7eead31-782c1a0314cmr914341137.10.1787696106365;
        Tue, 25 Aug 2026 15:15:06 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7830581026csm182093137.3.2026.08.25.15.15.06
        for <linux-cxl@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 15:15:06 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-782df51b4c1so147908137.3
        for <linux-cxl@vger.kernel.org>; Tue, 25 Aug 2026 15:15:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq92id46qASdnLnJzool1hwFnnE/2wap+FGm7GUkoUx5CgK0e4q3OoKHFDNFR5V7faUB/MbaTLqd+Q=@vger.kernel.org
X-Received: by 2002:a05:6830:7104:b0:7f1:ddf1:c731 with SMTP id
 46e09a7af769-7f4c5097628mr2648400a34.13.1787695731676; Tue, 25 Aug 2026
 15:08:51 -0700 (PDT)
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
 <CAJfpegsC-D0AJij3E=dbKzZCH0nijE7+rpPut-EnRd3r0uCMtg@mail.gmail.com>
 <20260822002111.GA6110@frogsfrogsfrogs> <20260825-hinab-kanarienvogel-mitschnitt-04a662533a24@brauner>
In-Reply-To: <20260825-hinab-kanarienvogel-mitschnitt-04a662533a24@brauner>
From: Neal Gompa <neal@gompa.dev>
Date: Tue, 25 Aug 2026 18:08:14 -0400
X-Gmail-Original-Message-ID: <CAEg-Je8d0kKH=kPiG7RDK4jGiTvECyOA_uFkZzbuvDpR+owJEA@mail.gmail.com>
X-Gm-Features: AcwNN1Ug6ZjMUQh0-6_7H39nZVAq6SWCLa31cOPu7pwraCiDoCVhUYh7Q1UxHT4
Message-ID: <CAEg-Je8d0kKH=kPiG7RDK4jGiTvECyOA_uFkZzbuvDpR+owJEA@mail.gmail.com>
Subject: Re: [PATCH V12 02/12] famfs: Module operations, fs_context, and mount
To: Christian Brauner <brauner@kernel.org>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, John Groves <john@jagalactic.com>, John Groves <John@groves.net>, 
	Dan Williams <djbw@kernel.org>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Jake Edge <jake@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
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
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 9:44=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> > > Without John's trust I'm not taking this on.
> >
> > Whatever path you and John decide on, I would very much like to see the
> > question of Which famfs driver do we merge? to be resolved for 7.4.
>
> While it is reasonable to place limits on how long a series is pushed
> out (I like to move with some speed myself.) we have two competing
> implementations and that will have to play out. We should not merge an
> fs just to finally merge _something_. The fact that this was more
> contentious than usual doesn't imply we need to merge a version, doesn't
> matter which one it is. That's a bad reason.
>

Well, after 12 iterations in this version alone (working on this for
three years) and forcing multiple side quests on John, I think it's
not very fair to him to keep stringing him along like this.

At this point, I find it hard to believe there's much more to discuss
about a not-a-filesystem that is relatively isolated from the rest of
us. I've been following this discussion and while I don't necessarily
grok everything, I understand it well enough to know that someone
should just shepherd it through with John and just work things out in
post. Honestly, the amount of metaphorical heartburn that must have
been generated by this is insane. If I had any say worth a damn, I'd
say let's just have Darrick work with John to close it out and get it
landed for 7.4.

Ultimately, the question of which famfs should be merged should be
decided by John and Darrick (presuming we just all let Darrick
shepherd this through). This has gone on way too long, I'm getting
echoes of the sched_ext mess... :/


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!
