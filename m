Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A1233936D
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 10:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784717232; cv=pass; b=nB/SVGMLz8++0mWTM+EJUg//4v6wwhHnMsEowePUtTWaTJQPnNvgTnDNYYiHSDs2tUV0ax6lXteU/h4MYBo0MUrvOjU/SiOTCPK/6bHZN1dYj68YRp8b9YDQvDjRgSsZKqG9+8XFC2VnTzKSmyx/CeH6CnjSCb8XBzUeNc2pJ8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784717232; c=relaxed/simple;
	bh=guAhZjJfEBfSY1xp7Mz+NJHa/zurYwT9YHjF7Gv7gyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vy/rIqBixWMMpN1FlYs0bTCezbghIYSDuoIjB0Q5iKgn5LgmcjLdU9Faj/CNG7R0NnuuNaaxqoeYGSPPeacGpvZCg2X58TyVnizGAARho78Z9lRMpyADwn2/UltZpVFVsE7S8+ysQqOSkilYTS7EG0oye9aVwAqrIas8mqBuQyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=WzF0IGAO; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="WzF0IGAO"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e5c9211d2so1107790485a.1
        for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 03:47:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784717229; cv=none;
        d=google.com; s=arc-20260327;
        b=Wy81GV3pfEbdNa7zs4W/P9mrs7eJoOcz3yXxzZwlh8uw/9ncGcyPQrNBqRi5B/K3iC
         jin6zyJ/boC91xXnxqhZ9QcxZbi8W5aIQLcsrrNz5OfD8RUA9nJkMuv9p6BvhkaGZX/C
         N3KQkQBM7wA1zntojRaT8VhaQ43gAh4WDiUmlH7DbRP1tINKjjQgj0CLT/8Ygfe0yD09
         Pnq0cpR/jVtcoioSPxBOxflhmrDhzG0FLyrag74wYrGIqvMZ292zvm5yisb71hgG8wte
         igZgxkfYsFkMMSWracxgikYs6bi+6H7laAzPgcgNzBehyYcwxxYVox+y1q3a5tQtA+ko
         QEAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7RG0U3kjlqqprl+YQXEPz8chW66ssUd6wO7da8Gt0so=;
        fh=SyW4JgRUHxhGCCECSIzvP72OVIhbL9KUqLdl7gxKr2c=;
        b=Po+nlJabqzwy8lGnAh5oVQpksgxuE9RDIOIk8LPurhr8ZNPtxHjNu62Gm0Z5VmRXF0
         lwQsFBy+/YVlh0C9/IMOev3CBKnkFU97wRZbH29giGzjeu1Bg8pTy9PgiAtve6rRSug5
         vvCXH8thHXOi8AOOBwjeJEmxdopsoJ1iACrJcx3FteK3M4Ji4ztEGDy9OqzudkIAbu1h
         hJSpzbz7fKoEYAvuEVWP1j6RiD+K6ntrtzb4NWzEMwr8mTHPRTvXPs2tLmF9Wunozn6B
         eQuiPk4TinUWwR3uktSq9xp8lPwer3BQcVzPrMp+TXFneUJRVZxJkhxnmf5kjantIeMv
         oIBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1784717229; x=1785322029; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7RG0U3kjlqqprl+YQXEPz8chW66ssUd6wO7da8Gt0so=;
        b=WzF0IGAO8mdfhq9zY44w4C5y2L/qBa3gVWxDXR8IV0PNZdJPpSNBFYMY5Zy1xo+Yts
         pxh19SRJBfAZg7UXoyxxNCoRuWhdiFV+EUPu5TU6JDGsnV0kX0k7br5iJ/D1GUcgganS
         LmLPrKR8ufjbA+A2HHUYQQXuCOnPNlUA3CCWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784717229; x=1785322029;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7RG0U3kjlqqprl+YQXEPz8chW66ssUd6wO7da8Gt0so=;
        b=GVoS2jpmBQrAt8/mjXiB/DEaaaAhZIXATmqxH9Tki8I94hvqscJhbQ1oh1IVRysxJ5
         RiJCjYRTfYrk7Itl/YPsGx+IlNo3nWmP+O8RXHhbAsVTvFQkjC/6YzBuqaAqY6SDy6HB
         rzhWH4EHwsphAqU8nyepcCFg8IIGfDiFIBjYz8TRnRioEHBHfU/RsnODBhwYRA7wIYgr
         vaAn20jv8JizG0KXbiLMSq7rkfHn4O1/LojB5baEu0s6PsrBsveBI3QYGkNG8DoSOE5w
         1MOXeY6piWomXETjasF0Kqdj0UnLlM9qnU93ZRx2XQVc3h5b3OzmdYgaPMkaes/NzJqV
         oFPw==
X-Forwarded-Encrypted: i=1; AHgh+Rp668kFiV8QgjyCvHJXN4KLylOguHAwfgVMoNi8PzNsLn/SLqWWpS/7uG5MJjaICsazHX0YSSr3a7c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu0PRCQJj4Al4AiRpYOC0vmp2JWkFinxw23wvGujIJml9wBRtb
	GrpaqlqFQE2ml6sPdNxMYD5Wu/UNGRE2icJ4ExKfEbcUKV0UbIersf5qh0CSIPN0Rt9vkUTBK6R
	U1WNHndlownxYp+dHWimn0lSN5GGYtoFY/MZ9pHKjCQ==
X-Gm-Gg: AR+sD11/W5H81yrHc/3ZGrg5wMve/L2RMCEzAgvS+IStbs8/Myc/O7G88agI2OAUVG2
	c1+QG7O9EPh2DgBg2jPPNqz4RBo4jiBRn7ZqDYtYaPLPC1VWvtCC0gXUAwBKWbZGmev8clSll/h
	ZQfjZomRdZTjp/HuOwxqC/NELy2Gjq/NCxO5uoVEpctRcOAJV4W/4vrSnx/XLuCcWcS8ngpVW1k
	1C4gCnb5YNHtelxEBtkb04RbTr56RFT5yXR3iwxBb02YT9mzp5fGuYJ88pJPlCM846HTtTf7Ibb
	QcTKCiRUDEZWlpoxRA==
X-Received: by 2002:a05:620a:4608:b0:92e:c118:18b9 with SMTP id
 af79cd13be357-930b43c45a4mr2167343785a.88.1784717229070; Wed, 22 Jul 2026
 03:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720034358.68714-1-john@jagalactic.com> <0100019f7d9fbe81-6cb16662-2522-47ea-a152-fab0ee3d9b35-000000@email.amazonses.com>
 <CAOQ4uxiEzP2e=cRw-AiGxtSv6WMSA5yR3cmgrF97s7ggU6wzqg@mail.gmail.com>
In-Reply-To: <CAOQ4uxiEzP2e=cRw-AiGxtSv6WMSA5yR3cmgrF97s7ggU6wzqg@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 Jul 2026 12:46:57 +0200
X-Gm-Features: AUfX_mwdbQYshU7Eh86-5S9-gpZDCDD0EXLkbKHjoCISvWGty4DcFL-X4n78Y2Y
Message-ID: <CAJfpegt9PwHksYhsQZeCsW0eooXVVihyieTpeHMmC-+Pq8BWaw@mail.gmail.com>
Subject: Re: [PATCH V11 0/9] famfs: port into fuse
To: Amir Goldstein <amir73il@gmail.com>
Cc: John Groves <john@jagalactic.com>, John Groves <John@groves.net>, Dan Williams <djbw@kernel.org>, 
	Bernd Schubert <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Stefan Hajnoczi <shajnocz@redhat.com>, 
	Joanne Koong <joannelkoong@gmail.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
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

On Mon, 20 Jul 2026 at 12:07, Amir Goldstein <amir73il@gmail.com> wrote:

> It's not about this ioctl, it's about infrastructure reuse.
> It's about the fact that there is NOTHING special about dax_devlist;
> and no reason not to manage it via backing_files_map.
>
> The reason you stated was that you want userspace to determine the
> daxdev_index/backing_id - fine, no problem - this is why I asked that
> you pass it the desired backing_id in the ioctl.
> In fact I think that all fuse backing_ids would be better assigned by user space
> so the extension of padding => backing_id is not unique to famfs.

Right, so I suggest to just reuse FUSE_DEV_IOC_BACKING_OPEN and add
two flags: one to enable user supplied backing ID and the other to
indicate that fd refers to DAX device.  The changes to do compared to
the current patchset are quite minimal.

> And the best part is that this request requires no changes to your userspace.
> You already bite the bullet and maintain the new/old uapi but changing the
> kernel implementation does not require this burden from you, so to be honest
> I really don't understand why you did not follow Miklos' suggestion.

Code reuse is also important, but I understand John's position to want
to separate famfs from existing codebase as much as possible.  And
because this is an implementation detail I don't want to make this a
show stopper.  We can easily fix it later.

> > - Lose the famfs interleaved extent format. I have complied with this request.
> >   It makes some things worse, but we'll discuss that later.
> >
>
> I am really not aware of a request to lose the interleaved extent format.
> How can this patch [2] from Miklos which reimplements this format as a generic
> uapi be mistaken for a request to lose this format?

Let's not care.  We can easily add this later if famfs (or any other
use case) decides to want this after all.

Making the initial patchset smaller is win in any case.

> Let me recap the former review requests as I understand them:
>
> 1. Use ioctl instead of GET_DAXDEV

This is done, just need to reuse the existing ioctl instead of add a
new one with the same semantics (okay not true because of the fixed
backing ID extension...)

> 2. Use backing files infra for daxdev table

Leave this later.

> 3. Use ioctl instead of GET_FMAP

Not sure we agreed to use an ioctl for extent mapping.   What we did
agree on was to use a generic interface that doesn't have anything
famfs specific in it.

John, can you please also look at review comments provided by Sashiko?

Thanks,
Miklos
