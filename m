Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120433D646E
	for <linux-cxl@vger.kernel.org>; Tue, 14 Apr 2026 13:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776172792; cv=pass; b=NdGxrd0xAXOjRcoOWtcLYFdkqO36btr7KVNK8EAGodd/ihJ270L1aFiJ5Pj1OfCYiidsfDG9Iugg4vHuZ74rMDxyZxAtOtDLzP5iCSXyDZxokVEyBLZyO0CQuknlLfCCsK63P/zB1H1sT16PCyaLSmK/ZAUGwVMYRGHxH54ekys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776172792; c=relaxed/simple;
	bh=ryFgEXHGkmMuSpJJwpuJTVtwXQi8vggb0ychK1MApVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1GtLijgpkFojgneuxou/AWYlkF/Kgtu5sdMUHRgQY0yjglvhFSUjuLjF3W6CKpTHD1DG0o4SIMAwk5PgIlD8tACvaeAW7VW0vGpLcnpALPDctN1X8ki7Twlmerb+OUzMkruZoH275wuKCnNTbd7GiyBwX5CVWCv4NxLGLlFcYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=EdesvKDz; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="EdesvKDz"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50baf2df711so44742421cf.2
        for <linux-cxl@vger.kernel.org>; Tue, 14 Apr 2026 06:19:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776172790; cv=none;
        d=google.com; s=arc-20240605;
        b=WVkYbz+AISqYRf+JJmfcH2t8Oi7ew6jGimkNx5z+MrWiOlZ+YlLVkYjG9EqajK/9ve
         PG9oBYYjtoV9wuGPfex+RTuJaoV+lVxtUJdeGtzPox+phKmX7LuMgWtHl4bHSB7adB8X
         EPQwejKuavRTw4sMdNnFZgANyoBgp+g9ay84PlgOsxpQ3xEOchTWq/4uhikKpSv0JCI3
         a63pcFrkFsb6Zu3gzKWvoMvVL67Rs3C5Nd0v90eDgH3MQ4P+aEPVBSrQA7G1hMM4tLba
         i7Z9obn51wWBCTxXNmIUGPRGDN1wfE7eTS/tmHFYNokA+it51ENIRe7hWa/z4VkLqVra
         pRPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+CXxVRVcoz/2rqD2Y6nyYCqWM6bYEnwjERb2zuGyero=;
        fh=tgAjrodvG3nSXcJh5MJ24MMa2OFwkXWHeFOwEpWn2mo=;
        b=I1pkZ+RkfyLUUAGdBDUxlMeK5oKJzwnF9B3/vPab2m0XF4BQ5+F6QpWlco5geJq8p9
         Uiy7YIVgjJFnnOVReMCGE7Se2hz90VzxDWIQh7TFczKVgyCcZDlZrdMPv2B2UGmkobT9
         ljAUuVtIALwsMO9gfypwHtSRj0tDJjXp+JVx0oZjRK3cmjQ/Cmy+Mo64DvmNDHAWo9hi
         5L2g29sGgeC6KBPlUakpOZdR5DKVMT7LGadWBswH2Bz2fWatsb/Ps9EWqlSTtXSOMmjK
         Z991jAswnExIZfF4uiNfX9unO8IzZTYTmQBtwTSAkGawB7yLXXegg9FOFMy+gUxpsvbp
         SfXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776172790; x=1776777590; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+CXxVRVcoz/2rqD2Y6nyYCqWM6bYEnwjERb2zuGyero=;
        b=EdesvKDzFMu6T/NN5owN0NDzG9s+SXgDPUsDbVYCn9yKIf8kwdQE2lTuYVmGiAxzE9
         0DHMCrmYz6U1MzaS5L9krJ64waA1cSWpenp3CcdBgFkMfiSvvJgMJCraKAc1dSuOHo18
         bUw+BOsn4AQvTlcbhfLZdWy6XiGKSVD/tAHlM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776172790; x=1776777590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+CXxVRVcoz/2rqD2Y6nyYCqWM6bYEnwjERb2zuGyero=;
        b=EiFGrIMI9dDVZO5Nh9+O9/QbL2yVbK5q/pjhB7LLN1+d6v0QtwYi+s2SSGz8pgfChV
         2XOuIwzk0meCDeCLY7El7gVsAHLVwcS9Ng4/NNAzSOhmuRhjTgSOisu7fJJ8sbSMR3GN
         Ep7l9VnVWmigmiS5MIpq9oE/Zqk/DO1XuZlw7mnWPe4dLiwdbNujR5XAEK72O7bQ2Fnq
         QIO/FPGd5ghplr8XJD4EKaCKteLetRy8Cl1C20KtMXf8iYakWT0qwMBtGbqKZpa+OweL
         rv7SnmxYYQ8Sp+/1eUdyY8lA0bu5kxtt6nzClt3pJvE/lZy0P5dfC8JUtLUOF1c+N4mT
         jCQQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Qtui6rZCpDK2pMWxwSBWeU6bTDmXxUwjYTuMTDJSomK40XrVWGo/IyHVo6oQan9TaM0zzbxn74QA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj4JXKtQI6URwejtoauqBoX+9kXBDPODMbGVQqFDPyvQgzFvez
	9zGcau4PMZnC01PyzchnKH+0gWLo7+yccXKhOD7PVm6PewlDaFWpL8vS/WrCdprrNXTpqVYb5QZ
	19YnyS1r8SMSDn/H23L6/Am5M/ahK3fI9wcyCWC0y1Q==
X-Gm-Gg: AeBDiev4HwciPds9+0MT5F+zP4vo6AfV76f7bxdEiocELdmEert3gvz+TgUsGxsEQ9A
	DMw10JBb3NBxfaqqfvU/yAgljpFCFelX50OPS4IfVNCUdOFr+ecyu+sExjAnuBWtcXn8LVsQ4U5
	HuDnpTX89irLtsoNN6XdQA2vQe4Kpo11bSWnILUgU4B6f3oHbBde2UH4w6C+YgZAFExEnTMGZvR
	KvSEooRPGJOrpcN08jV2snu59mXLS57bDpwelJFwMmTClysyTURDIcogWGRlVCjsRnc6ajgAALr
	hRinfD6Mi0vZGENdMCqbB1ft9VIhiWp4clEk
X-Received: by 2002:a05:622a:1114:b0:50d:e471:2d1e with SMTP id
 d75a77b69052e-50de471307cmr196909641cf.35.1776172788501; Tue, 14 Apr 2026
 06:19:48 -0700 (PDT)
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
In-Reply-To: <CAJnrk1a06zkUmXW5EFiUmgAoFauwtzsYvnotaPH0ifVtyh7iDQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 14 Apr 2026 15:19:36 +0200
X-Gm-Features: AQROBzAjmnDDuarHcsoLUx4J604uFTw3mmrQVyJlb1VBhLQLJU1-3tqIq-XH-a0
Message-ID: <CAJfpegvVTcV89=q3L326aGQjhduBcv7PVg5QKftGLjNZmCLmaw@mail.gmail.com>
Subject: Re: [PATCH V10 00/10] famfs: port into fuse
To: Joanne Koong <joannelkoong@gmail.com>
Cc: John Groves <John@groves.net>, Bernd Schubert <bernd@bsbernd.com>, 
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

On Fri, 10 Apr 2026 at 21:44, Joanne Koong <joannelkoong@gmail.com> wrote:

> Overall, my intention with bringing this up is just to make sure we're
> at least aware of this alternative before anything is merged and
> permanent. If Miklos and you think we should land this series, then
> I'm on board with that.

TBH, I'd prefer not to add the famfs specific mapping interface if not
absolutely necessary.  This was the main sticking point originally,
but there seemed to be no better alternative.

However with the bpf approach this would be gone, which is great.

So let us please at least have a try at this. I'm not into bpf yet,
but willing to learn.

Thanks,
Miklos
