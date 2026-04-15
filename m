Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F964396567
	for <linux-cxl@vger.kernel.org>; Wed, 15 Apr 2026 14:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776261906; cv=pass; b=rtkp0a2Dcv2EHkNJNWim52NhSUuiqnDVRFJKhfyGT0J5gmUZo7xFDGVr8jvW0XQh4/UbeE9R/4bQTEfGJndQ+mQx3rMb6PxtZ/4BrdxNoitzwmOUfEeYDF7zUDL6n0tMFnoLAPzmpvjbQxMhIb44zn4LXCDUrChFsdYSvbRbr4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776261906; c=relaxed/simple;
	bh=OuxoKfF1eIFYHXEVVTIuTwEbgi2RzLTEr5xC4F2+szE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RKrOn7Qm+iLSp0bZaTdFZNLbpe64aNuDwyu/277H3q6F7oivufcuq648NIRp9PLMLQUIiMeP7Nwa+wSXmviSIz6nMCdZKe572CNxc87Sv/elDI23PtXyoMOEMpGzCHVjs/ksgwonlD9B+mIW/yISpM2Y3SrvyFcOED+r33tAwdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=ekVbcIdZ; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="ekVbcIdZ"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-506a7bbe9d0so54049461cf.0
        for <linux-cxl@vger.kernel.org>; Wed, 15 Apr 2026 07:05:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776261904; cv=none;
        d=google.com; s=arc-20240605;
        b=V1tDqr3Ze/Skfl1rkrxD+WKXAuItKPjhEXkibts9HecaymkT+EQYULnpPP2VCh58uA
         0DgYttQwNJBGM21oBs4wbV89NJWHHS9OKlN+NeyWhF7cobEr4wFJSTK+y6gNYSdEsgcO
         LvuV05f4hFeKxr9/dxIYDy8506yemU10zJGqJ1WzcG188zOeE6A0g13taxfobS6XYntb
         fF9CziGcS2Pm/gyG0BiU+WAbSQCWnnjrXPwHqMGuhuTKhSsXZqCqDUkoQbSzwcYzQXIY
         j1DatWmuFiRsYPRGQGamCThAAlhXVdzTyZ2hDqDAKhPNDTPAN8UL4vFDKQj5P7J9O59c
         0p8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Nn6fMxeMg8FDWayAItzG5oIgCrdJaKGk/78HcE957DA=;
        fh=ACrqIEpXE0dN+kaOdXhkmzk2hWtLkVJsSjoXDMZxJy8=;
        b=cbb+C+M4Jdph3WPh2ITo9PutgQELqLGBh2gqgu/xNzo0wsP9kL68FfQSpb0HTuAqJi
         OreFL8C9EQLY0amBvn0wDO7t/anP/UaUqTOKRXROlICr3Kko5TaOTQ0tb0D4xqj8V3ZF
         v86+tnIkPR4Q5jP09HLe/x2ahTcYrx1vfKSOan8qA/3e2OocwJri54ZWV8IZNoD4VkFQ
         N9mvBLCXyLbYSG8GcQ+/3pBKosD18lwQXhR/VOeHTd2OOaEMK1W3tjPpIP2DIufTS3FZ
         71hZTmJLa92h5Wi3XMxYTz+AWQqpd3Nr5mlxgG5hFUvedijYAhYT1tf2nPp6Bv5pOJ4m
         iTBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776261904; x=1776866704; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nn6fMxeMg8FDWayAItzG5oIgCrdJaKGk/78HcE957DA=;
        b=ekVbcIdZQI29b+3fJvGFFAIcMiRWw0JQnGl2jXt0eUF/NbJXxRCA6/0u4ZrPdPzn5C
         hpopkgk1KEC7PJoE2+NCfBogXftvcBXM3EKMQnna5/JTG6FnQlSDzYB+R9tAyhP6JuBn
         jEaev1RMbJw9SdD2+nFsnm6cRn2EoDaA3p42c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776261904; x=1776866704;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nn6fMxeMg8FDWayAItzG5oIgCrdJaKGk/78HcE957DA=;
        b=a5OAgKVV+wyXcg6H5jsyPFgLVPf30k7TdsUNez9joPnl4LeUMJjPd4EnwWU8YiK10n
         /mRxKUV9OfIa87Mf63vYWsw50iiWu2ubvcGt13ElZFzSawQ0DfwVi/+b3SEs/nTw7jng
         gvXxep1v265jZDMn+MrKs3OPxdkun6DxR3RtUGx5OY/7U3iLEHpSFy2mMsTXWmew1FGu
         SxiTeUB7NX514+rUTXUjkN2Mi+ANqEX+yVPEI4Em3w7gI9ZEFL8rGxw96zxLgL2zPDfK
         Tc1P/6KOHGWm9g+IFjU39cPexQG8Ne7CgERbzFm8MHvvSBvh2W2NFQBNRws0Hap7/N6x
         QrIw==
X-Forwarded-Encrypted: i=1; AFNElJ/aXKBO92+tOrCPswdOLhdoeWVyB7FuS+hG0Hfw1YAdRKsDIhy5vq1/olPF7dmTTDE9XJA9giJ1jmI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySq69mXL1kczEcinEVM5IUtTBAhfnj4U2MH6SFSb5C8NuLcRCc
	/rc+iWgdVk/hwvWaCodep58fNY2/lEwkZ38mL6b0Wt59T0OBR8vf9FCAy4EQrEacTPrDR6OqRnM
	J4BOUznKoBXkIYaUxV0i77NEgI4QcnJhULr/rpfTZAg==
X-Gm-Gg: AeBDieujTbPa+BzAk85Uh8BwDeNofKbPcMyrwIvD5xtdN0EbNk5abLMdJZn+CM4kA0G
	Oro9wdwAYpnR4l8IAQV5CeJpaGD9wz73ZLdMQK5dT4SIZYG6PssS9bO46kQc7a6IZ/nvyNb6jar
	MjdnwvSFhTCArGCXI+2XVJ7N4YrZyundfMk8UhlAqji/A/o+lKJuJSRlXNng9JK/w+XFyAbV7nV
	10xUPbpIw2QvyujoyN6jGkitFJCze4sl3CBRtwuv3vw2Zagbmihs/IbkY3nr7JUzUb8v2aW5fXv
	zULYr2qlgCkN/6XnvZ81pqHYO4WhiwUym8rV
X-Received: by 2002:ac8:57d4:0:b0:50b:567a:e915 with SMTP id
 d75a77b69052e-50dd5c10ad8mr322793641cf.64.1776261903663; Wed, 15 Apr 2026
 07:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1ZRTGWjNzkMxS3UkeZMmrpadJDtWKontMx2=d-smXYq=w@mail.gmail.com>
 <adkDq0m5Wt9YhJ8A@groves.net> <38744253-efa3-41c5-a491-b177a4a4c835@bsbernd.com>
 <adlBcwJjLOQDAR65@groves.net> <CAJnrk1a06zkUmXW5EFiUmgAoFauwtzsYvnotaPH0ifVtyh7iDQ@mail.gmail.com>
 <CAJfpegvVTcV89=q3L326aGQjhduBcv7PVg5QKftGLjNZmCLmaw@mail.gmail.com>
 <ad4_jFsR951c2Mtn@groves.net> <20260414185740.GA604658@frogsfrogsfrogs>
 <ad69tTnx5YkD4Y9K@gourry-fedora-PF4VCD3F> <f254f6fc-dc06-4612-82d7-35bb10dbd32e@kernel.org>
 <ad-UAMcALRubBcHk@gourry-fedora-PF4VCD3F>
In-Reply-To: <ad-UAMcALRubBcHk@gourry-fedora-PF4VCD3F>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 15 Apr 2026 16:04:50 +0200
X-Gm-Features: AQROBzArU4_0DWulqMJjaZBbvqSvSBgOVsWveoXthohq7f36XvJ72ClRliOsfUQ
Message-ID: <CAJfpegsUVv0ziMSQiq9pKeXf6G-+LROPTW077hHMSmAirVCLQw@mail.gmail.com>
Subject: Re: [PATCH V10 00/10] famfs: port into fuse
To: Gregory Price <gourry@gourry.net>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, John Groves <John@groves.net>, 
	Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd@bsbernd.com>, 
	John Groves <john@jagalactic.com>, Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
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

On Wed, 15 Apr 2026 at 15:35, Gregory Price <gourry@gourry.net> wrote:

> This was my first reaction when I realized the BPF program would be
> controlling iomap return value in the fault path.  Big ol' (!)  popped
> up over my head.

I'm wondering which part of this triggers the big (!).

BPF program being run in the fault path?

Or that the return value from the BPF function is used as iomap?

Or something else?

Thanks,
Miklos
