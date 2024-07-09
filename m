Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4591DA303
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jul 2024 07:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720509811; cv=none; b=C4lpmE5L8gAsl2JyjMcnml6fLXHViRSKFWrJzsWccTqf4a1UdL/0n8l78aOyQMmrRw79X2JQgiXoYi/MQ/WFrYF66idoSjeK+lzqcO0d36BhZmHV1lSuR745ayhHfd7f/YrdBER6LoMJuBmRmusuCN8mNGHc9c192N4vMJDw2g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720509811; c=relaxed/simple;
	bh=I6lbVuspFaNyRYSuk2F/+m8iDvX98yteS9dVVhyRtMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iY3ycpnNhto5ZHvzn8vAM/pT3OTcTDfBoukbTNR51bLyy+1VHqSljIIrjmIUsTMzK6ZDU9Kon0ths3xHEpuSY9ZofndjtMfn6XRyMjk1Jm5YeyhuaKRE09t5NFK9cMe1Pp4ra4n0EocCsUXzFvti4sDm53omuOVA+t+vT8q4qZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUGIsoPG; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUGIsoPG"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e026a2238d8so5189854276.0
        for <linux-cxl@vger.kernel.org>; Tue, 09 Jul 2024 00:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720509809; x=1721114609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9qnnHvJc8SAQkCLOI/EYc+s35D4T3p4bH8nOKHF7k/M=;
        b=jUGIsoPGP2SU6MlT3L9zBftThuTo4TW2p0j98uvZPe4kVBaDJELg6vL2OAcuvt0PVy
         PTbAAjk1YHSoZFTFXx5SpP+Oi8ugMsddZ0OBl8Nm2n/MyU9rzdCEerjJbP/HBYMMky2a
         4ljwtEfgXXr0WVr8Xlq+7YwJH07xYx7QVH7mPiUapAZmYWbNxjCKbeDyut1M24TBM27C
         RWA/acT15g7AuyJo3VGCiJgB4qyExQchJb5ikCnPYF7l18GB4pyCUreRuUoJ88khVj7w
         0W9W6SN2EPKYqg9xo5/iMeO7omg7VnaDfEMI4jhVBGU0YYUCRdUyoP+xmqoHdV/KADkj
         Vlwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720509809; x=1721114609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9qnnHvJc8SAQkCLOI/EYc+s35D4T3p4bH8nOKHF7k/M=;
        b=qPUcIG0fXGjXN2ea/cY5gY/y4nUhNXZB/UwPQiQ8RwjIqI5bBP4RguXzgX/KU3fwFT
         FRZ1/DSWiuDNz2er3bV2QECRld4fpB+CN6EwbbGsssqkHGCy/nzB7hneetwJjNNBtCVZ
         QLSeL8VUqPs/cv2/aGGZ7v2u9huLXsupxQOQEMzwN+D348QQH2TbFil8HOz12+g6zKiw
         XZjCpRMx4TSVW+hCM9IGfZi8FLSDRSemI66IJe3A1S2q1REnuWl0DBiEuDAQPY5QtV0n
         szmUbms0tMcYauycZmWrUNKjynr75OXbIzTf9EEMAQLM+VG0cMOagjox4y2aCU72Dtrh
         +jOA==
X-Forwarded-Encrypted: i=1; AJvYcCXklZvDGVwLCqG5asVyBJHX3rO+/wO9Jy8OHH276xOx1PbLw/0vKjE9o/z3k/sSYL+T7xym/5blyf9lWmz7ijP0tZwXQmSn9pDA
X-Gm-Message-State: AOJu0YzdywAjCDOLciXRMR6oLUHZHdiCLLX6eHXs0tBJBhplr6wBg7ZQ
	zX5448r74cJwUDt0WOH1TK9RipFTw5YYIiqsK73Uw6HbJ7zwYtLp5pmAJfSneqSBFL1NmM+4LAF
	o8vw+agApictBdY8zmGlOzVti3xM=
X-Google-Smtp-Source: AGHT+IHRbvRNVlj0FdxgmEes/AJ5x14mxDUEumZnPyZXUuc7XmdnR/PR+P1zh7zD9LegBacDuaQrBjfFPhbpuDRYIEA=
X-Received: by 2002:a25:bfc4:0:b0:e03:41c8:4fbf with SMTP id
 3f1490d57ef6-e041b05be6dmr2325858276.15.1720509809023; Tue, 09 Jul 2024
 00:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALX8JfQ1F+DJ1woPP=gFvnEyy4qHqGkN+94CKG5ONQy+L3C5_A@mail.gmail.com>
 <668c877f86daf_102cc2941b@dwillia2-xfh.jf.intel.com.notmuch> <ZozTTpbMjff82vO0@infradead.org>
In-Reply-To: <ZozTTpbMjff82vO0@infradead.org>
From: Yee Li <seven.yi.lee@gmail.com>
Date: Tue, 9 Jul 2024 15:22:53 +0800
Message-ID: <CALX8JfQwCFsF4AvCwiui_7J08j41jJiSTLMVCQTx++EseguEdg@mail.gmail.com>
Subject: Re: Is there any plan to support CXL GPF in Linux
To: Christoph Hellwig <hch@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As I know, for cxl pmem, the DRAM cache is very large (even equal to
NAND flash). The data is stored in the DRAM cache. Data sync during
power loss or some sync operations. Data is stored in the DRAM cache
for most of the time.

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2024=E5=B9=B47=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=BA=8C 14:06=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Jul 08, 2024 at 05:42:39PM -0700, Dan Williams wrote:
> > One thing that guide does not cover is what should OS software do with =
a
> > dirty shutdown failure. To my knowledge there is no specific plumbing
> > for handling NVME device write-cache failures beyond: "hope filesystem
> > logging and metadata checksums can recover a consistent filesystem".
> >
> > I do agree that the driver has a responsibility to set switch timeout
> > values, but that is more an unfortunate complexity imposed by the spec.
> > Just set the max and rely on devices to minimize GPF response times to
> > avoid the worst case wait times that those timeouts imply. In any event=
,
> > enabling that is "up for grabs."
>
> Why would anyone specifically care about a (presumably non-volatile) writ=
e
> cache failure?  A non-volatile write cache is simply part of the device
> and it's failure rate guarantee.  So any data lost from it will be
> recovered the same way as a media failure, SOC failure, interconnect
> failure, etc.
>
