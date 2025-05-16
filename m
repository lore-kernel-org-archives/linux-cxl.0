Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F00223371F
	for <linux-cxl@vger.kernel.org>; Fri, 16 May 2025 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747390019; cv=none; b=UEr9OpEmzzY5wMXvLmzPjzOOImKM/7coaLpjMUOuvUffNLPrL0h/x3YvcBjV5bM3TQVrhD+xilzeirbjaDmXQOljgva3xOuLiL/fdh8fdmqFurnX4ZMjxWoQXnFWN4Y+1rk/fM/3loIkKfmQ+dBkylUxlYB9nEuh5TY+vbrO6u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747390019; c=relaxed/simple;
	bh=PZ1hzhVLhPa3dLDbMLplQU4Z4StkFXuYbw7/HI9oWu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkoxq+HasRX32V/G1m8kPL5xo5sigfhaFeX3qWLHyHQ4lOWAs8C9jpzK2Jtm+ohDfi9N910mNdz0fJ1c30ycXklGvkD8JKisHwtiAdryPKw9UnTJjFMDLS/tQmAo0t2w0L8obruckI3hzeoQ5OxKX4nP3pAvNhMtQOGBvkXS81s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Q2yObfd3; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Q2yObfd3"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-476b4c9faa2so27974501cf.3
        for <linux-cxl@vger.kernel.org>; Fri, 16 May 2025 03:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1747390016; x=1747994816; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sYr4H36z0vOGSYanC1w0/PBFKEWt1tWAZvghYgV0VXg=;
        b=Q2yObfd32ppE92QCNh3FmQzpGJVQIMNxEUm6x5bXLgiqgoo46K5nyHKNOjGcAqbemp
         XCzovOtqA5NEaBLxS0I6sqJRDmdqHGQJ34ko+evlxLbg9MjtbqSGRDdCtThEDw2qLt3/
         bnigLsB8NS4D6wnRo4FM3E1HTAe1FzaZ5BZC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747390016; x=1747994816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sYr4H36z0vOGSYanC1w0/PBFKEWt1tWAZvghYgV0VXg=;
        b=UrwvMoH4DxmF5XR+R3ZiltuVXd/4RR3U46ckSix/e502FIWnI+EK6ceaUHEl2S4H4C
         Hw92Bgp6+lMLuUGhZhiZ+VA/LWq2/R8ucl7HSSGYwhzpfgtZ4uSpSbtzgtiTQgrnoiot
         aN8DZAVZh7yqvfTlOKft//snbwGLZYZmqnkc+5h4BH4hrYtTj7lou46ttOTd3TGf+v5+
         ATbzW21o9apyHPRuTaOmYsTyIppqWPpPKgAyyroJMg9M8YdovkK1fwQNB5659F/H/YaU
         SVhQEgUJpk+gmO0oaHCyfGFnhKW3VTG2KsbOHYIfml5f3RNm8X73WNgIIam0dqSp9kxO
         C0Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVmcYyJQ4bvKFhEAwwx6IYT7oJ9jfkraNKBE6Nq6EIa8LvTz0mnl9B04bhfkYiwdzEOs1TBPJNHKgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5c4++FbFA9HTGvlZ7mfqBa6iMbNaz0+0EQqPOGGWyPLM5TawR
	17fodpEy52kYF98NoCbsgCnt7VugN2ieHoxdoVf+B56Dulfz6EH909wGINmQEzDzXKT10MzcPGx
	ljuM7MB56BBY4xGa6aJwRLoRRzMmuronChdMmiuJ3qg==
X-Gm-Gg: ASbGncsxHerxbdgnbODc6Dw26wOCqcg0QN/CxLPXUHR4NnA9noemG4c2Dx02Vhn2j1A
	pmsuXHqqKi4Xe+517K8X7chodnpgbq9Z6iDBIWxOchPRZUUAeJfgUAUqHNrLdU5yYnpUA2aKXdY
	4UlKRE4LSCMG2Oj07u6WuoFI/gGPNgsCc=
X-Google-Smtp-Source: AGHT+IFq1iLsujGv3MRAp/42wUNDp8Fjtx0tUWAIAmM1RivLIsnYNC1bAGTr6piq4vefDLhpVhUdj5QcvATegQP1E2k=
X-Received: by 2002:a05:622a:1f9b:b0:477:13b7:8336 with SMTP id
 d75a77b69052e-494ae391ca0mr49345951cf.17.1747390016120; Fri, 16 May 2025
 03:06:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250421013346.32530-1-john@groves.net> <20250421013346.32530-14-john@groves.net>
 <nedxmpb7fnovsgbp2nu6y3cpvduop775jw6leywmmervdrenbn@kp6xy2sm4gxr>
 <20250424143848.GN25700@frogsfrogsfrogs> <5rwwzsya6f7dkf4de2uje2b3f6fxewrcl4nv5ba6jh6chk36f3@ushxiwxojisf>
 <20250428190010.GB1035866@frogsfrogsfrogs> <CAJfpegtR28rH1VA-442kS_ZCjbHf-WDD+w_FgrAkWDBxvzmN_g@mail.gmail.com>
 <20250508155644.GM1035866@frogsfrogsfrogs> <CAJfpegt4drCVNomOLqcU8JHM+qLrO1JwaQbp69xnGdjLn5O6wA@mail.gmail.com>
 <20250515020624.GP1035866@frogsfrogsfrogs>
In-Reply-To: <20250515020624.GP1035866@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 16 May 2025 12:06:44 +0200
X-Gm-Features: AX0GCFvDzLpmkF12kGaynggeZWP00Cr6BBFBchrM1Bqzro0NRWRGfjqCVUyzE8E
Message-ID: <CAJfpegsKf8Zog3Q6Vd1kBmD6anLSdyYyxy4BjD-dvcyWOyr4QQ@mail.gmail.com>
Subject: Re: [RFC PATCH 13/19] famfs_fuse: Create files with famfs fmaps
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Groves <John@groves.net>, Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Luis Henriques <luis@igalia.com>, Randy Dunlap <rdunlap@infradead.org>, 
	Jeff Layton <jlayton@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Petr Vorel <pvorel@suse.cz>, Brian Foster <bfoster@redhat.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Aravind Ramesh <arramesh@micron.com>, 
	Ajay Joshi <ajayjoshi@micron.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 May 2025 at 04:06, Darrick J. Wong <djwong@kernel.org> wrote:

> Yeah, it's confusing.  The design doc tries to clarify this, but this is
> roughly what we need for fuse:
>
> FUSE_IOMAP_OP_WRITE being set means we're writing to the file.
> FUSE_IOMAP_OP_ZERO being set means we're zeroing the file.
> Neither of those being set means we're reading the file.
>
> (3 different operations)

Okay, I get why these need to be distinct cases.

Am I right that the only read is sanely cacheable?

> FUSE_IOMAP_OP_DIRECT being set means directio, and it not being set
> means pagecache.
>
> (and one flag, for 6 different types of IO)

Why does this make a difference?

Okay, maybe I can imagine difference allocation strategies.  Which
means that it only matters for the write case?

> FUSE_IOMAP_OP_REPORT is set all by itself for things like FIEMAP and
> SEEK_DATA/HOLE.

Which should again always be the same as the read case, no?

Thanks,
Miklos
