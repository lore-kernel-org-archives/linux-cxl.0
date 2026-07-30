Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EA73C061D
	for <linux-cxl@vger.kernel.org>; Thu, 30 Jul 2026 20:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785445170; cv=pass; b=fTZotoy49ygsV091NWxprbG3My3PBSm5qEOAnn6kja+n/wJ3uIWdZzub9ywbev2hzMFOFSehQXvhqpysjA5LGiHF6nk7jfD8SUs4BNjcwdiNk9VSOj15Ly9ytE10Jq9NiLLfzADBlGXTs8hBzDn7vU86u5QWdW+770ks5/rvwxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785445170; c=relaxed/simple;
	bh=TjfWFjcumtGogPzfLKW4RhkCh9Rhh17DgLYBpsrtvDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T5gRv1Ei2PfPrJ12qambXyCpPAPetr0oTfRkH2+M38Q2WSA2LornTEkSopxfCYNpTxJP05pMDMQJq/hWyZN76/6yIXsJDF8kWokJUarh5inzeAo8uERkGLaAeRIxV8Hna6/zhCFsZyZ2wK2nOxe0jApsUp4X4XiaC55aw1Kf/1M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R6ME+3Hp; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6ME+3Hp"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49550ec592cso7807525e9.0
        for <linux-cxl@vger.kernel.org>; Thu, 30 Jul 2026 13:59:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785445166; cv=none;
        d=google.com; s=arc-20260327;
        b=Ch79mrI0MXf7Fq9jjFLeuOBMEJc0+J+nQiQ9P7s4hQQzDEAFllN7rdFagxOpv0NAXa
         yjRUZpZulqbyApHP56J/eJ8PwaDctP3up64NrGFkFMR55FkPafpZDro8ATV8vZXJSo5j
         imwB3HLetqp/w7Zle46Gb8svJkVPMu+SHrw7RVgmaLjCtDo8J8/+vd8su3UEAJG7dBuw
         FMqwMc3bpJ1uuxgufXhdDt2JXtcUe/VsNxsJpyx2rArL1c383reIAtmk8uMkzssjU0N+
         lH9tMRBaEGNHnh5mWrR+kkBjoLLp62KpU4Wb9OEEQJiC+H3EfxP9bFfSCt/QGSAPgBwQ
         bjug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TjfWFjcumtGogPzfLKW4RhkCh9Rhh17DgLYBpsrtvDg=;
        fh=LX2saRGL5dsgD14xDpn+/o5AOtBYG0lPQ/LbyAb1Ge0=;
        b=ET57Z0wJ5BduofSlYuXQf0b3+XX76IcddGyEdgalU7x3ONhsHw+K895xdeLrgoSz0z
         nZER5fuDOxK93pRwfRf63FH3df9v3AsDaZz8MlH0FyChzGTkhJYGM2xJHM6acXWVOPHt
         /0lIHVJauivtZCrqvxTFFVRshfHdhuCCe6NnkLlpM1skY3BIqb6IVW2cXGzVBjrYVEbZ
         b+Rvi6iz4XZMhgm17O4hZ9UbfIAHu9jn51fsPY7qWRU/IuPqtPdoaJ/AvcjEb+gTaix3
         kdyg48LvKuG1F1l/f/MIJ916bBQGFaarm91MGIjqTiXhwpkCPh7X5r1IipNgY5DLIo45
         OCiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785445166; x=1786049966; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TjfWFjcumtGogPzfLKW4RhkCh9Rhh17DgLYBpsrtvDg=;
        b=R6ME+3HpvtKodB5vMz0HHdPy/tumwxk9eembr/QeHJJMiqq+apXcoGz7XZc43ETGd7
         O8NIVDm2Uxanw1UE2eD+0O6cByz3cIg34hczcsHbkvyM4zMxOkRF+fp7e6HFxiNdCyqF
         mlDU0nwiZkucLp2N0Mksf4zxO7W904kuFt8Dk8kGpRmilj+cy3+4PHQh1OhUMuGiFXjH
         LVPVUCNwrKaIJpSsIFW7XOikTaCgZK6wmtyrpJOGyMzx7KefmrsTEXonBIYS7Z+D6ogI
         lFvfmp6EKz8kYmHwGulCC68bCuCe8OV5dmzEtsXeIYAn2CF5fWeClCLjySPRlu4hEX9r
         mr1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785445166; x=1786049966;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TjfWFjcumtGogPzfLKW4RhkCh9Rhh17DgLYBpsrtvDg=;
        b=asCLGNl03FL0o3FwfvxdftFSRgaThI9GFutXWmmfQK8NN8r2L6DuzWOvty++2Z6ulW
         cbzbXkdi1UX5YfSS5SJtiNlHyZrfVHnDm8nLwAuWarBnJhQUmlkmauEGgnEIb1jfGf/H
         HhozYqYF1fkkYR/lrMPwBYP5Tg240W9/S4KHjN8hYpr9DdDfTLlNguzCT2KY0WOrw1bY
         C0wk3uGWrK+77RWAbZa5RsI2ENqm7Y6ZGJxiXx7Qypa65MD8yQ51UVMzQ/ooNqQUIKk3
         h6CcZlHOjak1nemtOA0DPsr8U04sx/v1stmXVhSyKYlkgJpgjcsN82v7ziQiNx1BiJ4E
         V9cw==
X-Forwarded-Encrypted: i=1; AHgh+RqB/LEtOz97kzA078o1S2PJ4dqmcZRLFn/Zb953MawnDevwfOUFxLxU9QhvmMMkdOOspiTvgLM/9m0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyctjRXL9Jirbi8pEypY2TbnFcnEslz7MPRDrlOsuNCfWO6gB5A
	Vz5yhHpBOBusjlyurrS+bNqgsU9d6uMf5vDwlMeZV6KnIfOJlx3GD8M+m57ioKJ46K2428yn0nY
	17EbhTQgs0DKO9eDmgR5bC+lzmT0TVEs=
X-Gm-Gg: AR+sD13rAtouaC+oB/t2AuejTXOPvJy254eact7ozwi5ux7g+l9DBoUHdiISccEWiSs
	ITv+IKt0m8BRSVQP/KOm9noAqs6XD6o5UAB2z65t8NeESPi1vsILWhRzSx9prBBFC2/dahjI1Mz
	dHGEQlEs1VBBZnpMRmO293iN+A2R5/NAF61zSfFnGJVMsQpa/GMHhlj4kyqi4OK7722bAADqqEE
	GSBi19Xq1+p0CU4AX3bfhxiIZu+Y+aMRWjOj5PzGxHbv+ibCIX3eo0QfDHNa9BVyf7ct6HopZ+o
	eLW1HLRbIH7r7riVna7AsICrMCi9CJKdbQ4y4b9x4GxVS4VfkotZaxumJIKzRzwFmkFCB8KEBV1
	tE7Ynkbp6C8EkKXio+heN+lZq
X-Received: by 2002:a05:600c:5641:b0:495:50b6:5a6d with SMTP id
 5b1f17b1804b1-49804c4cc7bmr22571485e9.12.1785445166339; Thu, 30 Jul 2026
 13:59:26 -0700 (PDT)
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
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 30 Jul 2026 13:59:14 -0700
X-Gm-Features: AUfX_myiGnqGNN965xypoyGuHF_KvdnF6l6Z1HdJgtyCUEVPa6_UpbiR6bYul1c
Message-ID: <CAJnrk1aj4B-T14SMTZhst2XsjOkKWStUj_0cjwHswgYWWuaB4w@mail.gmail.com>
Subject: Re: [PATCH V11 0/9] famfs: port into fuse
To: Miklos Szeredi <miklos@szeredi.hu>
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
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 1:23=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> As I understand it, the merge window for 7.3 closes at the end of
> August. Just to summarize, the only things needed to get this into 7.3
> (besides addressing the Sashiko comments) are:
> a) replace FUSE_GET_FMAP with FUSE_NOTIFY_EXTENT_MAP (will also be
> good for famfs in general, saves an extra context switch)
> b) remove FUSE_DEV_IOC_DAXDEV_OPEN and reuse existing
> FUSE_DEV_IOC_BACKING_OPEN (logic for this already supplied in Miklos's
> patch in [1])
> c) remove "config FUSE_FAMFS_DAX"
> d) remove FUSE_DAX_FMAP capability (not 100% sure about this, but
> since the only thing added to the uapi is a new notif type, seems fine
> to exclude this cap flag)
>

John, is your intention still to get this into 7.3 through fuse? If so
and if you're pressed for time, I'm happy to take on the items as
follow-up patches to your series, if that would be helpful.

Thanks,
Joanne
