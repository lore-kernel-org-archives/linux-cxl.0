Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8B03546E1
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728762; cv=pass; b=DeP67Wybq6xjVesn9aPGWKUqHAdfgXNYwRfKac+Vyvj+lcK8Dmi0GkoEnRVudlVtk8pCZKHoY8zngMPDfak6YaUxeReU9FmIuBLPZ6VE2Hcw+0Td+1BF9kNd0st3/BO1VjDx7ombC+Ldqzw8hbeP0bK059lLJ6+/shdyDh6oZ0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728762; c=relaxed/simple;
	bh=l8OyTHPsSiXlV3Gjth/iDTYvVrHiTPTknws/b6slKyk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qnRl9kcNORpZn+chhP48/vwP29Onqs9j6dvXard9Lvn83XYe6IKbzm0c9UvadW6F4mmNJlVaKZwjSwGz1X6NqdC5Vi12KdqToJAgkhy7LKh0lOZBSXt2QXW2wQr9omzL0k4S3beM1NXil2PKGlbJdg6JXI317ceuBvJBCLA0o5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=IRDA8cgu; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="IRDA8cgu"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-51c21495722so88889161cf.3
        for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 06:59:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784728758; cv=none;
        d=google.com; s=arc-20260327;
        b=YunSflLqIR7LoJs/bNXAtIZeNi5nqKUbe31METMY/yfGTVFFFRtuHr03MvtMeLSxO9
         1LhZvqiXwoN/rUOAn2tLXP39W9YIIYblBFNocspsxq8qPSbH2Tp1ZQ552UQ+POCubO+5
         aoTOFHiOKoLR1HZXwIegXSE+7QD5E+nWhhextCZss+bPBStajHccVRenJlXsnag3cSd5
         l0Z9AxJneFOkT1oJNqSpWVVrCPOKdCwno4agHRiOFAX1dYVQXROpv5eJR8D0uihPPisp
         YYQFcFIJaBLo4GYIIY/vgLVQF1yNxE12Q+/HbCkYgRPI4/PZXwyZzAk3UJmVUWZ98N+v
         2Kzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=vQ2/EjZAmPdGp5icD1VFPQXMQudnf/IhCWBft3t6T2U=;
        fh=is5S+IvqPVT7hrY8fWFQOzYsi/ek5NyOquNtf+5gvaE=;
        b=Q7RS2qcg9ww4HcMS5P0PJEoxSgCdjKK+jBQ8wj2r/heTYaZbCnj28PAG2w+ShO8hEB
         ZaYkeLJ6mkx8Y0CtdNfr33ekw7XCVl15AGY1L4kDnKR1fXSR2YuJDWlAsinw18mqvpcH
         MZ6aGhCPdb1OzzJQsysZIO+H+ijJm2ng7+TpVY/Cs355nUYfkuR8k1RC9M6bQhDIHgk5
         Iopw7sD3yh4ZzhiVKnKVJE1xJblDmXOS8E6xC6p4FmMy5Tsmgy0YMqQy7GSwnKBRdAJt
         L+7j5jf5BFjvFRKQfitF5ywhxTnyKqQoG9svXhiMm8Wqo8RClHLTyUN8GS3oT06BE2wY
         V/vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1784728758; x=1785333558; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vQ2/EjZAmPdGp5icD1VFPQXMQudnf/IhCWBft3t6T2U=;
        b=IRDA8cguHMO2QzhU7NBs3YGsQgtYSQxWG7i9N1JAl1eUNlB9Q4IO2o01XqKibODgRO
         py+0DFOuMegMt9DXMmoo4OT+xXhqdAQDdx/0+U5Zav71E4OC3VRpjAoQmE4+UR15wZ/2
         BzkE0lhRBahs2Rpn/+gnSpzjCNXuQjaFihV1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784728758; x=1785333558;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vQ2/EjZAmPdGp5icD1VFPQXMQudnf/IhCWBft3t6T2U=;
        b=fDZKWMNXs6QX9rxnYbhqZn/H7/24zue5LzR42HbCwwbMqzPqIoRuhMu7ri8ZiM18a6
         IpUaKOtlTHoYESnDbmvPTp0Ec2hUXXkEwiss2xrSr1/HMlqmXLs1SEhWwHDojwj1yUKW
         NsjqUhDNFm3Eiwsv6OdN/62dIo4BR4acCIlVcZXIBUIhFKPj9PQ6wuNVtne8WTOLfB9S
         9MilLMrRnPGGEpj0cnsOysmYZJSmDlS7hpM2qunb0iKK7r6kgxXhBqbpgIZL8yJbwZp8
         p4/fLrBEVQPYS9Fq7Bs9WkX06KvZcuDnucqv/3yu1LH2K/2RQLLDZfs/DOUMZdXKYOYB
         VzVw==
X-Forwarded-Encrypted: i=1; AHgh+RoroT/JxCVQHFx/sbVGVmLZLuos6gEkyeEERZB3L4oY8Rpx0+l3jtZDeKtcLGpQMhLDNiDFMgnYcKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2lfawErsRb/mCGcvUsPIQP6Yb+2QG4TGq5oQnZY/jjlxFYX7k
	tKVXW+cR1VWsZTfP2eqH3nih9D81zskzQ1KEtJTyeckoU2VaqRZq5QeZ0OS+9g+hVPwkYgw67dB
	uQqSIGZapsDJRLkdymD72VxtdWwF7OyR8iIDb3Q7PCw==
X-Gm-Gg: AR+sD11IjXxZ1cHhBydoSuXW3nOYcAeXXLXuSn4xunwxCSE3KKbxi1y+3keiduXWIrg
	g/ExRt2WvCCZJG6l20/a3yFHXdvyV6d/1czkkcNKfrGMJl6WAdtidTF+wbfbi5fHdsGpo3sXyoH
	LKV7n3oPAThp4+mrwc5s24Nv8rAQBFVpDECW9Zm0PLosxBsay3VMMgzn4OY8IwAocALnIxGl3as
	/FuoVO5BG05aOK3JRahoFveowXvgUYEOfrhOW1XEBBY6LKGZGLZb38z6hCYbr7TAt1afJS7/lWW
	58bkycVODPcZFesccw==
X-Received: by 2002:ac8:5893:0:b0:51c:7b13:62f8 with SMTP id
 d75a77b69052e-5213eb800b4mr216533471cf.78.1784728758165; Wed, 22 Jul 2026
 06:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720034541.68781-1-john@jagalactic.com> <0100019f7d9fbe81-6cb16662-2522-47ea-a152-fab0ee3d9b35-000000@email.amazonses.com>
 <0100019f7da14ceb-fbd4edd7-ce17-4770-8c58-1296ad3e3fbe-000000@email.amazonses.com>
In-Reply-To: <0100019f7da14ceb-fbd4edd7-ce17-4770-8c58-1296ad3e3fbe-000000@email.amazonses.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 Jul 2026 15:59:07 +0200
X-Gm-Features: AUfX_mySW2J0tjX47cdgUqD8gQ_vf8pqX8_96NOWv8ZzqlVpdTk8edwifSp98Qg
Message-ID: <CAJfpeguf3EBgBrf=mrG2Jp=oNp65DDg1fZsdEaqgBn6UNNrZRg@mail.gmail.com>
Subject: Re: [PATCH V11 3/9] famfs_fuse: Plumb the GET_FMAP message/response
To: John Groves <john@jagalactic.com>
Cc: John Groves <John@groves.net>, Dan Williams <djbw@kernel.org>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	Chen Linxuan <chenlinxuan@uniontech.com>, James Morse <james.morse@arm.com>, 
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

On Mon, 20 Jul 2026 at 05:45, John Groves <john@jagalactic.com> wrote:

> +       /*
> +        * The fmap size is not known in advance. Start with a modest buffer and,
> +        * if the server reports (via the returned header's fmap_size) that the
> +        * whole fmap did not fit, reallocate exactly that size and retry once.
> +        * The server learns our buffer size from the request's
> +        * fuse_getxattr_in.size (GETXATTR-style size probe).

No need to retry.  I'll post a patch to dynamically allocate the reply
buffer (already posted as part of fusex).

> +        */
> +       for (attempt = 0; ; attempt++) {
> +               struct fuse_getxattr_in in = { .size = bufsize };
> +               struct fuse_famfs_fmap_header *fmh;

This struct isn't defined until the next patch.

Thanks,
Miklos
