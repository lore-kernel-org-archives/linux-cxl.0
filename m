Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90AA3859FF
	for <linux-cxl@vger.kernel.org>; Tue, 14 Apr 2026 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176327; cv=pass; b=XA5NeE7snm409QzpHCqautuwlapdWLDINUv6QK92ZzCXm+aKq0PTYtS2tDRcjuZELW+mBlANf9XiLRQOuRyBzjsEDzQ4Q1++vL0XEq6SecteiOYUvhWRyuLr9eLqiS/eKV/SSjf96REWZCnPovz7UGxBu7nSzzXNVOU+iBv4kis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176327; c=relaxed/simple;
	bh=qR1ARNJXhgZbUhvZNjjyKFCNkW5s8L/UcZxIWeoFM80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Taqyt1cbfPIIRvooiklf3TOhgozVr2ZixlobBuveOoCebFmW4I0ioyMg34UZ7FWT4uBhQRCc58E5pKlDdRJNNaUgXBUXesf2viJKmzv5fW8VHXWxm086fuK4Q5ONzIY3fBGob56VJjUabmifnGiewD2cgJXdlU0QVodJW2FfXh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=aLYDXS56; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="aLYDXS56"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50b69bf5638so61996351cf.1
        for <linux-cxl@vger.kernel.org>; Tue, 14 Apr 2026 07:18:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776176325; cv=none;
        d=google.com; s=arc-20240605;
        b=YFwsPWNPBi5lWsebxbB4uaI5dRI9I+MwaQtUCSkFNgVkAxlD/wnvaCc4RzMD6yj9bX
         WkbSHaV/MF3lWnFYeYROTbtX6iO4Nn2Twxtmjk9QOH87eWWB2HA5kUuEp99iCmD9yzoA
         l6R8NEeDY6MdvsCTtt0d0sj4WwDaUnDv4SXtIRH2BRyjSuYacx2zs0j5FgBvp4QWLD0P
         RAxa83XwMJ2gAZc5dwvebqgz/m+9pSMMYASwpSNnZVzvN3Z8X1s3WcTpLOuSbwlwocWZ
         Ov1YDsJlSI5GxZLVo0LvEvbrlCcR/kxUdSRPSCZAJ+bypTeDluNMS6hUKiKvq1P95nPt
         6d8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=BeSg31i3cb+7JrMZOeE8E9eFnlQ6LWh5RGdI+wJ//2Q=;
        fh=iNsKxkwNdqy94U8eTP9ToR1lvDUtgh8ckitxdchmak0=;
        b=KUu8OBmQ9rRzRDRi+mNY8A3Rn4VBvF9mKYc6STNMgG/b5jUJUdL8+B16isrHogVGrx
         V/PV+6S7bW2uGyZaQ+LPz6WWhJzBkVgak34U7O1zq/zqIJicdqZ2IENjWK15KaQ3I5qo
         TjLSuudlXK2mg4LN3QCd7aVCoKWsuac8GDmRO1uCvSz6BeGhdgOj4VKdghFNRO9gdMRb
         +Aj1o6ORCsYf6tGSOQMnPQy60xTuDgmhY7vBy1Ai53GZlZm4cfFEL4vAva7WSGzHxYve
         /8DrpWEVFoCtyGuAuDfGeFXpWSTIHaaoW1bpBV9eK9E+wnZg+KFscwoTzePggiuQMkxX
         kHKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776176325; x=1776781125; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BeSg31i3cb+7JrMZOeE8E9eFnlQ6LWh5RGdI+wJ//2Q=;
        b=aLYDXS56/o8us38bnHNSLqBbnL5B3SDw60KVFLMVn/2uVKQovw9c/tHGitbk1B1TRq
         3otfycQbQbx4V1lBJhjRfPkygJLtKZp21KgnlPnDvKX4AG3hanVf0Jb2efE51AtavLQs
         3O7skEOmP7d9yay0IT50KL5zSiVztehyDeaM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776176325; x=1776781125;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeSg31i3cb+7JrMZOeE8E9eFnlQ6LWh5RGdI+wJ//2Q=;
        b=LSLb1+AZVV/5oPTFZNC8gugEmmEDHD2n4xsiPvb54YVW6KPfn6AEevSZPQMw08e3fU
         5rY8LY0IShDkVkb0C635whFz9hxmnPa8YejcHqo3G1fwr7wd/vL5nDbQMrmLQeAxPC6r
         zmAN7bnjB09Py5oIF06Hj4sE60S3gU0QA9CIAz9O6WvMMAYcmj870IBPK7Wwk/wAzIFK
         3aqGmfantzPztKFRM91ef2wV7/j54ysWuD+7NAmFF9GSMeQ0RuSsuNVVAkJ8vF1Mvalr
         f0PSXNMROmfWIVNbWBdcWkBV75Uo6do0QkQs11tiukFQw7BHTCr6+1YEgcJxLqAA3CKQ
         l9lg==
X-Forwarded-Encrypted: i=1; AFNElJ+mxWGn9+xgaaqMMW8DgGEgYTj5ZirDYWiZhkq42jfzIduPwvLm0jYNIZbb5DTyKOw1kNSZZ7R/NJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLoKLABODyRgioc8rw9uYOsVKUy7dnDznUyV4573HLgUPZvFSz
	hCVLBAYkBvrQwdwj+vVhoi/0RD4b6RbpwJ+OtWYsCvP0Kf1QZM0TOwkwPAmo0bOnozjgZoG/GP7
	KVd2kkGyhYnZLj2ZtcNfbnP4neMVssBpmlfusy2xEWQ==
X-Gm-Gg: AeBDieuQhtF6jBDbFPF3v4pHLRDx9W3is+T9aEmNBenSZn0cepTK2hljnlgsf7vorIx
	RH4Hv4FHlxKvTXiwnuXS9LK/zZVNcnoIbkw7Mq7HxTx74i+R0sd9HKFZOcKmrDZU1yXHlbVihKN
	wQ24xrLBX3oMLDluJopsurR1MByVz15/8zaJjCZ5tYSNJw/7frZk7XNY+v0eLq2aVDlBgJUO6c6
	sd8vTMaU2VF1Z08sQ09iOb++XvPAsZtuHJs4bV+gwsKC/ZmUTELbV74rjQsOu+hxA8kceUUpSMP
	ySxXlIePF2HgLwBhEeF2I5G5bVneE5MUTaVk/VmZ77oAv7E=
X-Received: by 2002:ac8:5d89:0:b0:50d:7135:5631 with SMTP id
 d75a77b69052e-50dd5b959fcmr266547411cf.6.1776176324547; Tue, 14 Apr 2026
 07:18:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331123702.35052-1-john@jagalactic.com> <0100019d43e5f632-f5862a3e-361c-4b54-a9a6-96c242a8f17a-000000@email.amazonses.com>
 <CAJnrk1ZRTGWjNzkMxS3UkeZMmrpadJDtWKontMx2=d-smXYq=w@mail.gmail.com>
 <adkDq0m5Wt9YhJ8A@groves.net> <38744253-efa3-41c5-a491-b177a4a4c835@bsbernd.com>
 <adlBcwJjLOQDAR65@groves.net> <CAJnrk1a06zkUmXW5EFiUmgAoFauwtzsYvnotaPH0ifVtyh7iDQ@mail.gmail.com>
 <CAJfpegvVTcV89=q3L326aGQjhduBcv7PVg5QKftGLjNZmCLmaw@mail.gmail.com> <ad4_jFsR951c2Mtn@groves.net>
In-Reply-To: <ad4_jFsR951c2Mtn@groves.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 14 Apr 2026 16:18:33 +0200
X-Gm-Features: AQROBzCjv32eXkH-VR3uBgnPuhuKjz5ZLSL9EY66Hi1IQzByLu6JpgnFl7pVZ3s
Message-ID: <CAJfpegsCoMMg-Ux3CbBh0d1uqDNg3Fu_8YE-LubwrQ6A-2Cggw@mail.gmail.com>
Subject: Re: [PATCH V10 00/10] famfs: port into fuse
To: John Groves <John@groves.net>
Cc: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bernd@bsbernd.com>, 
	John Groves <john@jagalactic.com>, Dan Williams <dan.j.williams@intel.com>, 
	Bernd Schubert <bschubert@ddn.com>, Alison Schofield <alison.schofield@intel.com>, 
	John Groves <jgroves@micron.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dave Jiang <dave.jiang@intel.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Josef Bacik <josef@toxicpanda.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Chen Linxuan <chenlinxuan@uniontech.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ackerley Tng <ackerleytng@google.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, djbw@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 14 Apr 2026 at 15:41, John Groves <John@groves.net> wrote:

> My short response: Noooooooooo!!!!!!

:) Seems like this is a highly emotional topic...  I suggest that we
go ahead with bpf experiments, then discuss results and path forward
at LSM.

Thanks,
Miklos
