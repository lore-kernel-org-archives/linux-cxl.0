Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C1739989D
	for <linux-cxl@vger.kernel.org>; Mon, 24 Aug 2026 07:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787557276; cv=pass; b=dXK4cNeAhAskFs4xPq6pUWKxzIQOQ7aMqd2TVpaObS+Hzu9JswYgpKU8mZljpvhESlXiaQmUZDWqRLNA7FM/sH7DSRLGH3bnCqx83KCBxbQYIysjMpG6GZOVBnRGiTyjeWNNt6tGRvD7nXGf6JoE99XEBXf7o9p90wgbl/j5G9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787557276; c=relaxed/simple;
	bh=mdsvrY0ISPRS0P8l6Q2ATVhO2qJcd3GXtM94ZK/661M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KV9ksOM0lugrjFGsTlM+od8QGKiUEc+ZbfrMQs1GPeDVxJX4SUhEx3mnfq7gnTjV3xfQ0pZsBKThFxxUQylA2qqKli8vviVVftU6ph3k7gRRqm54vEUEQXSIe9OxujPSj3PAF/6AHpE4+D7d3ig/inDcwZAXkxNdwDg+2EejeQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Q/GjEk//; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Q/GjEk//"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c08df8513so19135531cf.3
        for <linux-cxl@vger.kernel.org>; Mon, 24 Aug 2026 00:41:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787557272; cv=none;
        d=google.com; s=arc-20260327;
        b=HPOeukgS2CTzpUaHu0LzeE8ciiP4Z50DPcW1Lgdkh01M0khGs8sWUwgbtfft6S+PX6
         +b158dZxavR9+CnrhtD08DCkbwwMM+wVEanY8poNpPhkopTrcTUFT6xxMYK/wjoD3TS3
         +k1PCcBK+li/hIi5ruZhiVzdVItUyQhME2M34SsalQNwA541NXNBsfEmp6nnjOrApx1s
         yElflBa2rMRWZwAIvW63U8pDdrOMlTiKyFVQrDwg5HCIT8A6CyX5ZqZoilgkoMoNy5tZ
         Q+uNQokYlrkRi4ZrVH+owkWsD2qmpf/2xiw6ox6ViQlqHcgkgEfnGwvCIZ5/AepTiPrX
         EKyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Klk3k/9iOZSzHajoiDP/ePmCKQpQct/Ey07OIgVaiL8=;
        fh=2sc5DYN9L2J8kddQLrHf35b0ngF+I657vG5iWm1hwec=;
        b=eySAInPfbHFu8d56tg3iiqHbIzQMJqNG95PQs31e4ok4e2Afg9cJdqhdfV1DtMNgGZ
         Zy+TG7YOyqVm4OULhbkrx+gGlNVrWgG+OBL5w+ADq9khYaOLIvYgJJn1rquPf2zJ0jhn
         CJuj69QsWLAvYFlfdefF0BesCR73hittba20cSeC5j6MqoayfdqHq+oh44D4fOXr8HNa
         0SIDJwjKuQxOlFpcvp16mKkIV2hirBrJdrSHjQJ9qPNlWKBUS+A2SlK47urdMxMZpfIH
         +f5tu8Mns7fFJ3Pi2ze37fFBn67Uv0yqaze0Bo4nmYOq0Ug2YU+QerWsPnU5crUnE+b0
         t4dQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1787557272; x=1788162072; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Klk3k/9iOZSzHajoiDP/ePmCKQpQct/Ey07OIgVaiL8=;
        b=Q/GjEk//wp5xYL0vEr/+Agzjq//Un/YfKCErgxJp8r92qnipH2D8XXriluj8rI9O+p
         OROlfSSqPMyu6evEHcBJrDoN6E/NWadT+iOazfy8ukAc/+N+wat4eM5mPINHc44W0etI
         ummcPk0e15zddKt/9Gkx/GbWoKVDhyvdILB9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787557272; x=1788162072;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Klk3k/9iOZSzHajoiDP/ePmCKQpQct/Ey07OIgVaiL8=;
        b=ZhgaBvlvmrhN/kM+X4vT9VEWB8ETOHTHd+Mrm7iZnnJCuS/FGyKagRwBIb4wk3iJbr
         H23tnUXZ3GmFKar87yh5K+wHR7N1Gls+GORFyjUiknV8wmm+WUKDnLmtphWXBLi0HE/8
         NbQXQ1ISgl2g02wkCd2H8cIAwGtz6RyLaOkL6PWQSGs41b39N4KOO5TLYQA3mggcVz5S
         srB6NPch2lwxkIICKs7EiCWHe5evPaWNB7R5THjJ2itLc6XwwaCIoz1aSQcEnn7KJ6kD
         L60wyJeTTruhJ0s7eDOZcgnc1laNSOvd2+jwNAmdlovsGCJBls0hluM12Dqi2xWLBeaW
         QFcg==
X-Forwarded-Encrypted: i=1; AHgh+RoGGR4MTTUx+BMA3pw8ZNUq/yQJLbIy+WPvXptHe258YdXpJ3Anj5Gq6jPe+xjqHfbgwd7BfqTkjMg=@vger.kernel.org
X-Gm-Message-State: AFuF++mIm8h3dqmLIE/4iyvTlQ8fDv0PXI2OSbTT6GMzh4sj8J49OPPw
	PMNQR5aPcu123sLkL1FhUqKGqIdKkH94o2ZrgKX1l44D5ttPRGK07UXNhLFnYyBWF7DwbJVdLW1
	w/ZH77O3JZSSvay6/r+wRThZ4Z83cSe5ZU7Wgh+rKeA==
X-Gm-Gg: AR+sD12egmoY2bH+0At1KwejuP2Fa0lcjS5gLJdKxPcPICgEgRwrcHzMQ4ctPcjDP/n
	tWIVyQNIVLuD+fmDl93SZqOrONrrV3PKO52kL8kTTyYDsMC1uWcr2a4QK2jsjlOC0+WDmHawz2v
	ZZYbfTSKEg2Fuf9BKjxMtRFDhxHXjCwhSNMt1/JpmeQ4F2mmW12p0uwVloWuStK9impzdDXADAc
	+DULXok3crxiAMU3BoRfwnmAEnMMWNwLEzcV0yJ6xIJK0Uq6ODut8HxONtlXf3A1yhUjboTPLXJ
	p/vdmhh2rLL85MES8jIbWdRU6bJgzt3yBzOLKHUCrofJSPRRaluLQq5DGSurbZt5/uCj8kSTirc
	TtSI=
X-Received: by 2002:ac8:5815:0:b0:51c:1117:c6a with SMTP id
 d75a77b69052e-52df56f0b73mr226396731cf.4.1787557272431; Mon, 24 Aug 2026
 00:41:12 -0700 (PDT)
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
 <CAJfpegsC-D0AJij3E=dbKzZCH0nijE7+rpPut-EnRd3r0uCMtg@mail.gmail.com> <ea56c85b-d564-4451-b704-58448a07bfa6@app.fastmail.com>
In-Reply-To: <ea56c85b-d564-4451-b704-58448a07bfa6@app.fastmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 24 Aug 2026 09:41:00 +0200
X-Gm-Features: AcwNN1XWfONgBRIlU-yXy6CPly98fZpO_MCf0GW5eGggOdo-Gs861y_E4L66dCQ
Message-ID: <CAJfpeguuL8He4dKC0+CQU3c=Ss9nDEH=9VckB5mqxOr01X2q4Q@mail.gmail.com>
Subject: Re: [PATCH V12 02/12] famfs: Module operations, fs_context, and mount
To: John Groves <john@groves.net>
Cc: David Hildenbrand <david@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, John Groves <john@jagalactic.com>, Dan Williams <djbw@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>, 
	"John Groves (jgroves)" <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, Jake Edge <jake@lwn.net>, 
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

On Sat, 22 Aug 2026 at 23:55, John Groves <john@groves.net> wrote:

> Famfs does work in fuse, but some of the asks are things that I don't see
> how I can agree to. I think Miklos and I should discuss those 1:1, to figure
> out if there is a way forward.
>
> I think the virtual backing-dev thing is a non-starter,

The virtual backing-dev is an abstraction.

Is it sufficient for you if I promise that this is going to do the
same thing as the standalone famfs at the same performance level?

>  and I think that the famfs
> portion of the fuse ABI basically can't live without extents that are
> (daxdev, offset, length).

Sigh.  My proposal was (backing-id, offset, length).  Again this is an
abstraction.  A backing ID can be a daxdev, a striped logical device
or it can be a block dev or even a plain file.

> Also, I'm curious: if you don't know of a use case for the striping code outside
> of famfs, why ask famfs to completely rewrite that?  (and I agree, other
> than the eventual remote possibility of competing 'famfs-ng' fuse servers,
> I don't see much likelihood that this piece will be shared.)

Because the striping feature fits much better into a virtual device
API than the extent mapping API.  This is how striping has worked in
linux for the last 30 years.

> Miklos, I trust that you are a good faith actor, although you seem to be
> spread pretty thin. Can you commit to a series of 1:1 conversations with
> me to try to work through the disconnects?

Fine, let's find a time.

Thanks,
Miklos
