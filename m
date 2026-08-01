Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF163876B8
	for <linux-cxl@vger.kernel.org>; Sat,  1 Aug 2026 19:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785610941; cv=pass; b=m3xxwMRBJsYWfUt/aiEKDmHaRgrtWr2iCXNs2wgOWCBUGVwJq3CmhkYaAJ1o+T0qRQnDfdcxf0sJlj5uTsrU/+yYiCLK3jjPSVg8tn16E04FdWb3qCkZ6KOX/4ti5Du+9e9EOUKcJB3pCc5K5EN8R44cNzBLapSVbGFpO5+GdM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785610941; c=relaxed/simple;
	bh=nivli2INTpQAZY/8TzmpQ6V0d9mAXZr2We8tZu0CLGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZPwAg5UBaRDDpYf+INHRuSnlG/bLIs+DuT1KSUuj65cb7xdkw4XKaWnqEECndXnmbam3oIOME7zYJvA8dto5x9S66LCzd+HjPyP7ALjh2KcGQe4YW4aC+0zhBbgxxvQ/MuyLOoPsLNvcxLTBm4EchH+hrPtAXgTXVESvmWPm5jI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdUXF+3y; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdUXF+3y"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a0c8283146so591732a12.0
        for <linux-cxl@vger.kernel.org>; Sat, 01 Aug 2026 12:02:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785610938; cv=none;
        d=google.com; s=arc-20260327;
        b=Ri6cI4I+Yn7neBbALfm71EcF5v3PYVu/O2GhlDYrhQm1EaC3sac8r8XIClD6kROb6i
         gXldUkxS5Tywhd2rTt1CJin/tUBm4/XsW7y+YPcZZJYHosOLEjdQpr9QzwLLFansiLDi
         cS6gM/IjQzjb800UlIre4Nx+q8bi9cQL1/aOBUHUjCAZOeWXolEi9NAHLKXCrtxbB4gF
         y1oc3SLmcvNJkgNqVsAk298ZhhoUtjWyzA7u/7Cg+DtMrxYbNDUAA+CcldkYaY+7lLVR
         dzvorjW+JWDwvlct80phFd6MYZvaG0028STUgX1SOqy+TtCKlKLkTBuFP+HHV1oWlL/t
         xicA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nivli2INTpQAZY/8TzmpQ6V0d9mAXZr2We8tZu0CLGU=;
        fh=peE0sj0vnObJbU7EF50gG1su1d8pWJmtLuxArNWUfaw=;
        b=bawqA5DnDSkVXCn3xPp1CZiyP4L1XXhzyeM3LMC4zW5obaOW5S21K6eUrLIk4UkHbn
         HT7UdjsU0Ec7RtJv8EO2eNJ4PpivLutVc2uwdIUpJB4TeYVKqYyHu1Vk5zx4grQ4/mwh
         9JNXP7VhRMa1NxlUiEfoY5iw99bvOtqSnitbNMKUlCpbLL9J6T2ssKPswnW+dhfVx+tg
         aDTATjNTVV0LKldlNbuvYkc59u13kCyaDqN0BudiQKk9HPqa1E2D+kdl0v6h8/E/3bSk
         VvfWI6tYdDEZ9+zuhz9CD6qRg/XIWaFNcKCeDwP2t1LQqP895QY7RZmdPdHH1dKeNm8S
         oHwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785610938; x=1786215738; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nivli2INTpQAZY/8TzmpQ6V0d9mAXZr2We8tZu0CLGU=;
        b=KdUXF+3ykfIPwHSaJSeFEHofwhjSnI1tczDKFGkXUMnlNyR3F923FZqksKe39mHwW7
         dCFQwl+6lag2J8mXhqPdjSvJyOfv+oEGR1XZmRmdc/n+8d1Q4YUoJr2cQE8ttNrKZZtq
         q9RKXQGOJ9/j92E1PEnI+5lk20BK153agHD8gQsHInkqmhfCSGUddeIGwN1cziXS1f7t
         85D9Av9CzZ8sRacrA5DqqekOWA/HgBAaE6v7NVE1oM7qHZM6vcKSxa1M+a3CgrGhz9qE
         dXI0Fa+oxV2basBHwq944W/k3QT59qjYK6I8reBNZ2kIQ34OFLV7U2v2qBMOj0//Nh2K
         7YSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785610938; x=1786215738;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nivli2INTpQAZY/8TzmpQ6V0d9mAXZr2We8tZu0CLGU=;
        b=gxSjCAE9a83UBHS66Dl702UcXSg/KTTawl/AazJWV3GgVxzofg+fcFDdLT0ANraFd8
         Zjzvs6aaO67nvICQZwCnOtjQkZ3fqMNZS6dMTOBZalJOz0rW+/WulTTdAiJ6CibiKq7j
         uJzdI24T6PrwReP2GrsMKamG5KPqyjH12KAcSZNYGSHJgYA3Aujcvtd8iHvu2tJXzpMK
         ucg1jPZLEG6kEmLurJPYytEA7zzgaNtB+rBWDCCKY8oZF78qLFbVkeHjblkCY8bfBVWH
         aKqVZzjZZUz7OLi807E7bZrqXAuR6li/RmxxnS56LeODfl1L5eIMPfc1tHmNiHNlb5Wm
         H/pw==
X-Forwarded-Encrypted: i=1; AHgh+RqVe45bWXZj88YK9T57fSriP9KA085VBbu9qA6cu38jZxWUFznIzMwZsgDbM/uXJmRmmi4W96o6jc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxK/+1v2qa3DZjNOel6xZCJnkwLvi1Y0W5SXJiFVRtigBPg0UC
	5Z0IGfg47+BuSN85FwEA/IDNq/JGMFcTyEMRsVLjEUTY7O9Avo0qrbcOEEjTbMiaJAe9Gh8P4Ff
	AgzsOPrysT6RSiwNd724SKuOenXbjrOk=
X-Gm-Gg: AR+sD12KJgd0i45efx1B9jjjf3iGs8cEokSWkxEGoGhKDpptgbw2nDXdpbxohuHayeo
	EyDBcjzGW6eS7GTYazIhd4SztgkFedf5WiF/e7F5OurPv1GA/dnAZqgbRBC7yXGFsDoAs/ftkqM
	PYCIIS5E6NTDVoAuTUgGR6vzqccW2MYH/Y6u6ye8bv8jofltVf2Hx3mWjqjvsIkY/2ijy8P1cuZ
	3W+X31yculwWgAive1BhMUqyM0s771NoETTZAlqRaCZkNnnDRlahdn8awBuxo2gs0uNkIO6BIgP
	mVYJgml+I7mKgdEeOnIudL1J/O+UU9ij+63YndzmYK0TZtY=
X-Received: by 2002:a05:6402:449a:b0:697:de29:c802 with SMTP id
 4fb4d7f45d1cf-6a0a7ccb364mr2898579a12.18.1785610937994; Sat, 01 Aug 2026
 12:02:17 -0700 (PDT)
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
 <CAJfpegtnja6tkOnNPD2WZxu14Dd+UM9AvynsVB_E268iSXLbkQ@mail.gmail.com>
 <CAJnrk1a9mR-6hFie3hfFRgWTkrhJMVx4j9e7WGnjTRFuX2iJOg@mail.gmail.com> <CAJnrk1aj4B-T14SMTZhst2XsjOkKWStUj_0cjwHswgYWWuaB4w@mail.gmail.com>
In-Reply-To: <CAJnrk1aj4B-T14SMTZhst2XsjOkKWStUj_0cjwHswgYWWuaB4w@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 1 Aug 2026 21:02:06 +0200
X-Gm-Features: AUfX_mx0nmQgWA50AjJPZwCEcEACcDvMhxSi5YeCpVu2bWW7aLZWp00XQH36_Y0
Message-ID: <CAOQ4uxhop5bzpDxiqSdfHS8JyUASfAmpsmuhrpq7Ey28jATVsw@mail.gmail.com>
Subject: Re: [PATCH V11 0/9] famfs: port into fuse
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, John Groves <john@jagalactic.com>, 
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

On Thu, Jul 30, 2026 at 10:59=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Fri, Jul 24, 2026 at 1:23=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > As I understand it, the merge window for 7.3 closes at the end of
> > August. Just to summarize, the only things needed to get this into 7.3
> > (besides addressing the Sashiko comments) are:
> > a) replace FUSE_GET_FMAP with FUSE_NOTIFY_EXTENT_MAP (will also be
> > good for famfs in general, saves an extra context switch)
> > b) remove FUSE_DEV_IOC_DAXDEV_OPEN and reuse existing
> > FUSE_DEV_IOC_BACKING_OPEN (logic for this already supplied in Miklos's
> > patch in [1])
> > c) remove "config FUSE_FAMFS_DAX"
> > d) remove FUSE_DAX_FMAP capability (not 100% sure about this, but
> > since the only thing added to the uapi is a new notif type, seems fine
> > to exclude this cap flag)
> >

FWIW I'd rather keep the explicit negotiation flag and make it mutually
exclusive with FUSE_PASSTHROUGH (anything else)?

This will allow us reuse of fuse_passthrough infrastructure with less
concern about mixing the two use cases, which at this point seem
like two different use cases.

Thanks,
Amir.
