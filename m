Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661433644BC
	for <linux-cxl@vger.kernel.org>; Fri,  9 Jan 2026 18:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767983393; cv=none; b=hvX6xuK3vSX3v9zUGSftfqK1P2vKnzgT/cbObOFaiJx3LzQHtFs5DhToNeKv+/bC/F10lFJdd+zIKKndap9HKNXaO608jGDmTQmslI6Pqd3mB2ODd7Ol3MZxGzYfUDbWKmOxjJMOhwbb/WtzWd+bDKbLNGWF199c8jbPgB90BFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767983393; c=relaxed/simple;
	bh=00yYLGXhb42qUhp3Bu+hEI0Ws2wuU/ekKjA7ZDTW8ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QA+7BtMwslS9aoVQUUd/sGOHKXoX39KjnBVMZ3d65zBIFTIFkjzHdVOJjJnnj/8ybxBfhNwCqZeH2SJeIuPMyuueavk2RHJLIZEC7tW508DULKUOEaOBBIlPXWXC7ai+ZHcmiK1DSQEPXIILvJbFz9HRmZa0Sw9FQe7MxdGA7Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMLkvn9i; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMLkvn9i"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-88a3bba9fd4so44591896d6.2
        for <linux-cxl@vger.kernel.org>; Fri, 09 Jan 2026 10:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767983390; x=1768588190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAxsMd9qfhbaF/uFu/ONsXnhJzDpN/ZmkW3TT/4ib5s=;
        b=DMLkvn9i0zKrtfl3buWjSpr1Dd3UkSVxtv0lcl4RFWqfv9XUAjteb3RreFgBUkGN+n
         3iTiW0WeIroU3eMMfKD6QtOjdJpENTY0M5jN38ScYaf9hBw1Sp8fPyODWDHJIUPSMKNf
         sTm+QUuXTBVWtxLJ27IdDpG4XZusd8nfmgOviVhCpnVZHK+avVruXZbtI9+Bn5XdIfjI
         XLf+3NtoL6fbaIsdBK3Rz4/4ekeE13+IwrNAEnABB/8AgtMVgR7XEBwOZztjPUFnsby2
         LVQXS4ANBnLX5w/4KnL84RWfrTiMDGCxSfKCbKdfTdKDhAfVIB/SftzVs9CgwUSHjfeP
         AaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767983390; x=1768588190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cAxsMd9qfhbaF/uFu/ONsXnhJzDpN/ZmkW3TT/4ib5s=;
        b=a8BKEEu9+BK0G5Pj0NMIXAkF/jXI6jA4YNP/N22CNG1BdzXHS5diowDO0eqHOlQGLM
         70WsD8V70aLZTAMvMiXsFsaZs1V6ObbYohVVqTrXlftoshLTBCY7P2pFvsgzUonWrRez
         hlyoUr91cfpECrUBc6Gkvy2k+07v2hnR1EfV4SS0y6pNq7vweUclae8CYcy7+nQaA6Xk
         vKlDE/JgllREHQdOsKy46HTZQTdxNn+WWPSn2am2zgHMy3yAKFbbXEX2hiiY4EYafLTQ
         tZH0HB0ZZYtv8FCga3+s7sfgtZcP7Wvyt4ucW7DIIN5fuxGwAMFT/g0nY7nKPm9YW6vY
         OjXQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/R4yLBP4IOth2JP5Erv3gm5/P0t4+5zorSm0gcLA3gi0mWSdcMmQ86cPoRiopsubSeHYvE9jsBk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUP1Vq5TzcTwlovEGKEWMav+6W2SFkelQzIOkMleoNeP+s/DaT
	5P3UNj0+yRW1bhWGfGDGPiZbqVPPY26AMwCEMINarLHCBQk640Pe3OOv7+9jQIK5X1LAymzdag1
	mrVvLRd2oAV0t6IH90VSU5CDuJ7UmI5w=
X-Gm-Gg: AY/fxX4NXI6o6AorxOIXO5QRMbDGWvrD0TELJPSZ/dtBNB2rX4HsHkGrcLP/QfoHhZ7
	3xt9HzJzKu/WAViHd3WVNVtr62Mv8Ex9KNQNypkK50ha8dsWl2hwB4VaygM6HJh/U+3py1b5GV5
	Imk48eVHgR8FmTMYWU2a0qDeQM7PpPw30MqpQ8yYF7fYQKpxyrH1cUXxjGfw1F6mAapNTXHZjqy
	cZY5mhjnj35Zz+h1HE2cNhYnEIp5NHLUpvJOIPunDAMxga5IqB93tpE2MGmZj+ZykxYHQ==
X-Google-Smtp-Source: AGHT+IHlq/k6aGt3slZY7iNfrk9m2XRGsaHa25Bso2IebEcIgjfLBSdbUtZ1fL6PzKuJnwZWbWVzCQE+c2rsB6YWIcY=
X-Received: by 2002:a05:6214:268f:b0:882:437d:282d with SMTP id
 6a1803df08f44-890841ae54amr151687936d6.30.1767983389887; Fri, 09 Jan 2026
 10:29:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107153244.64703-1-john@groves.net> <20260107153332.64727-1-john@groves.net>
 <20260107153332.64727-13-john@groves.net>
In-Reply-To: <20260107153332.64727-13-john@groves.net>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 9 Jan 2026 10:29:38 -0800
X-Gm-Features: AQt7F2ol_drdQ3iXi69XhhLUyZBWJiqqNDBNu77Lc8heqKjvvqfcHiuhasXh1Zo
Message-ID: <CAJnrk1ZcY3R-iL2jNU3CYsrWBDY4phHM3ujtZybpYH2hZGpxCA@mail.gmail.com>
Subject: Re: [PATCH V3 12/21] famfs_fuse: Basic fuse kernel ABI enablement for famfs
To: John Groves <John@groves.net>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, venkataravis@micron.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 7:34=E2=80=AFAM John Groves <John@groves.net> wrote:
>
> * FUSE_DAX_FMAP flag in INIT request/reply
>
> * fuse_conn->famfs_iomap (enable famfs-mapped files) to denote a
>   famfs-enabled connection
>
> Signed-off-by: John Groves <john@groves.net>
> ---
>  fs/fuse/fuse_i.h          | 3 +++
>  fs/fuse/inode.c           | 6 ++++++
>  include/uapi/linux/fuse.h | 5 +++++
>  3 files changed, 14 insertions(+)
>
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index c13e1f9a2f12..5e2c93433823 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -240,6 +240,9 @@
>   *  - add FUSE_COPY_FILE_RANGE_64
>   *  - add struct fuse_copy_file_range_out
>   *  - add FUSE_NOTIFY_PRUNE
> + *
> + *  7.46
> + *    - Add FUSE_DAX_FMAP capability - ability to handle in-kernel fsdax=
 maps

very minor nit: the extra spacing before this line (and subsequent
lines in later patches) should be removed

>   */
>

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
