Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3597D42124F
	for <linux-cxl@vger.kernel.org>; Tue, 11 Aug 2026 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786438805; cv=pass; b=RMHufnVpqsXA1M8VliWGPEhBhaE2MI4w9YsZ3Iiay7oDCra66fXKUT49NW9XjhgQ/8SbvMC6XGiwEvlaGI4LYlf3XRm9X1RxDlU9H2WE/PQbWQ6DX4LCPzjnehb0x7uerSA46oH7bh3USJ3NdqdqjtKLgmBGEmOtb8OMliqg/rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786438805; c=relaxed/simple;
	bh=QAVJs6W1FBqjbAOF/0emhNqG9jbCkXvsyG1EUwOkxnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aaB5+zbyqsklKGnj5ksl67Xx3pE2kHPzB7wiQ6mOAQdT86NsQifzJUhRRDmFiveZqPtRRWYRpw9UEoYeOCwx3ttFVmPGIuuLHazBlqsydrVEADFtGUSlExp87UfCtkAp2cVa4noEbBm+FQBr4UrElnsRhBWhI0vrPP38sEhXS0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=nVGqfVwW; arc=pass smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="nVGqfVwW"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-930f4e5eed1so25927885a.2
        for <linux-cxl@vger.kernel.org>; Tue, 11 Aug 2026 02:00:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786438802; cv=none;
        d=google.com; s=arc-20260327;
        b=kittzQg0Ez7jGFk5N4fvMKVb7TbvHkdvhPSPBKEzfPvbjNOh//BwG+wncZIPhiTdmT
         NwHvlwRcC3OrW4TUtCN5aMgFD8VXilHkEQzAc3x/o8YLU9pbmXKdb1v8gQCbocmsPLog
         2DhrkR9V/JP6ORhKtGSmonxJUXEfPUvhtIxr8mk8dWZnQ6vhdo2wvorjgSB8oRbxfDZn
         KKRMS2jXg0rGqgszBqqSwNkrI501/A5MqELsqgUQNZ4CnRckzOw0hhDYS92u3F6u9LfU
         V0DisSYgFxT9zU1jSuBJaWsRCjlLx5hLTpeKKybG0xro63rDui7jaHjIjqwobbDlgMi/
         ptww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=03hUfqpAtMk8895qbCCQElojWBhsj8Ov0HHep5mUb5Q=;
        fh=1b3tuFr0qIq9DxyRYC9oVRigLUncEQLclWVYIiyrh3k=;
        b=Qd6+tcmeV5hUcvdmjuJOOmXGnhonTw3//JQacevfuszO3Y2Jw7D+tpr7D8d/NtJ2ph
         HsTbTrgQrrS++YTISYBAWkagm8xqchkpcJc8dWJ2VxqG5hos34F9zygHGPVrYG55JTgM
         /pzjECd/nzePY1uBkhQ3/67cCQi2Im1oDVxNAdLB0rFRzV8VZOV1jpn/nLssiR1zcMO4
         GxzbjY9wAF8OU5LulNiiyS8aCH5B00Hszft7xnglHSf5vWGig5iX7Kr9ACYuKF3TG07P
         rvOLaONmOuI7yipm8qQGHep4t450GzfBS6yIzWYzvw31p2LngKlDHKDhD5BUaJyx4EUQ
         32cQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1786438802; x=1787043602; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=03hUfqpAtMk8895qbCCQElojWBhsj8Ov0HHep5mUb5Q=;
        b=nVGqfVwWjlKnDAMJZhh695o7awjKGLhip0xvSsLu4dXRYuA/MyfJugV5EIgcKGVMek
         eViV3wgYs6WFhvQoXQjmOEGfuzMB8q69VBLz1GmMjUqkH6R3kn5QKpZUsFR3zbQIzp/Y
         aCNfEHr2HvjU3d8lq3tRlSU1rp9TZCMV6DJN0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786438802; x=1787043602;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=03hUfqpAtMk8895qbCCQElojWBhsj8Ov0HHep5mUb5Q=;
        b=NSkqZHHh9lvwUG1ADpT0eSDmqP19xEyLjjoG++zPIQLMERooTQx+2M9Qwzz+cf4Wl0
         WvkvFI+qWSPSQYXiXbt50KGskfJWGZH9aees5ywCp8XrZvxOItReHH5VK4oERAeBR1Wa
         pzOp0cO62FHZk5s6wrRpmSKcg382usK8ve84WAds31C9ePfNybMi75KNxfO+GHutJYHv
         jQibWDEJczfibHgmCEILZcY9VWHuXryDzx8+o84fm0txdH9jVzrkGMAenRxft5eEQlKW
         1Pg4wcGSmPos2jleuRxW/v/e6O4Y+tAz2m6RQCoNjXk19DeceqHH0u/z5KMjSB5DYdQU
         YvkQ==
X-Forwarded-Encrypted: i=1; AHgh+RrMcR9RY1RmbVyq+BtvrfemyCjtSjR7b/nziBbkRCvB/fr40AnFa4LZ2iSNt8zZcteMPdQZdV+1VIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6vGCKvPhjlAwJ4zs6d/AVnvY52itPgLJbQb7D7ABrId4UEKei
	T+XA5RuTRg8hKDtE/WlaiwbsRMo9oyARwNmH4+OlZ6t0ppcShIT0P//3LWPd46ZFCMeOWOtfUfi
	U3RqB9haiupaW3KS82bmBc9ssYxO5z47Pv1PV/GTRLg==
X-Gm-Gg: AR+sD10opjaFu11rJ5J1HmCzcmJF7+yggAjyLIdNzirSXMjCQU64gibvbOxgbkiIJ9h
	dob9+b8Fxd0IAMH5S5o2EehkKu3uV4Wjw996RclLZWVltZ4crsOJIq+4wBlKfNzTsyhvE2ubTgT
	Io7yhgpeC1HQA1neH97i9GjoPkN7/XIPW/CgTRYyRoKHtLH++dy68pY8JEU3fZnrnnLxUsjJa95
	8xshxTkqtab2XmwmbCY/mKQoA5M3JPJIvE/jpOdBrS3Xy4XNj/B+KobgJm7IYhMZwCtiIO8xjxG
	lF+HeJ+PbHqIIFsQWXONwWD/JCYMi8jy7PEnaHnzSEt1s2GOLEyKL9w2S4WHEy3JpoJruH+XqbJ
	oISH9k6whog==
X-Received: by 2002:a05:620a:26a9:b0:930:9774:868e with SMTP id
 af79cd13be357-936a8e70eb3mr130606285a.7.1786438801859; Tue, 11 Aug 2026
 02:00:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0100019fc572ca94-ec363dd7-3a77-484b-b4b7-f2503a0931a6-000000@email.amazonses.com>
 <20260803022828.75776-1-john@jagalactic.com> <0100019fc5739e5d-bc002300-eede-4c40-9ca8-a277b754496e-000000@email.amazonses.com>
 <20260806043712.GB3560084@frogsfrogsfrogs>
In-Reply-To: <20260806043712.GB3560084@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Aug 2026 10:59:50 +0200
X-Gm-Features: AUfX_mzPBN-WtEK90PQcEbgkE1jczoRAdcaPSoPUxrlnLvA164kB5DWNAs636Zo
Message-ID: <CAJfpegtW4bFn=oNfTipCxhiExaqSXnhXeBd6Uq15FpepqCJaPQ@mail.gmail.com>
Subject: Re: [PATCH V12 02/12] famfs: Module operations, fs_context, and mount
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: John Groves <john@jagalactic.com>, John Groves <John@groves.net>, Dan Williams <djbw@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, Jake Edge <jake@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
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

On Thu, 6 Aug 2026 at 06:37, Darrick J. Wong <djwong@kernel.org> wrote:

> IOWs, let's fix the remaining wobbles (if any) and just merge this
> already.  No more side quests through gigantic refactorings of fusex,
> that's too much to ask after you already redesigned and reimplemented
> the whole thing already.

Without any intention to change the direction, let me just state some facts:

 - it was never suggested that famfs depend on the fusex work in any way

 - the plan to add famfs mappings to fuse was laid out two and a half
years ago in reply to the very first rfc posting and has basically
remained unchanged since then:

https://lore.kernel.org/all/CAJfpegv8XzFvty_x00UehUQxw9ai8BytvGNXE8SL03zfsTN6ag@mail.gmail.com/

I understand how that seemingly simple API addition was overwhelming
for John, and I should have been more proactive in helping with the
implementation.  That's entirely my fault.

On the other hand John could have been more trusting that the plan will work.

But that's behind us now, let's move on...

Thanks,
Miklos
