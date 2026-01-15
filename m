Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696471373
	for <linux-cxl@vger.kernel.org>; Thu, 15 Jan 2026 00:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768437659; cv=none; b=XOWSMLN1nlhxR3ziu6fuJV+oh0E5Bpv64XDTfXmknoibxMOmqbaHk1NR79ku85ty6zm3u5ptdWo2hFKElongeqDTWnc3MCPJXxkXNc5+Uif6OLi10B10Q7jhClQvC0TiaNG4mv3tZiYuFEYS+W9FrY63v0dVXj+JlLn4ig2YucE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768437659; c=relaxed/simple;
	bh=8kwQTxZEOGNZ+MI9z8E7dyWDZVVqYLa/Ly/GOaJt7Wk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=daUi2OueSmunbwdjLPGSBUeWJvb5N2+gWnaPGUKrRiFyBLRdiHfMr7x0xrMmtffy6oAnD6pEmAyl71M7LX5Lv0xFwjD5OekSL8RaDkJ7YjzDP/M6KA0WmAkQZJ8Ie7UZ+7BKh+PDQ8YWoxNrgn1/+f4ca+JZOQ1yFOBvfp4pQ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDXEEx4H; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDXEEx4H"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-88a37cb5afdso19433526d6.0
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 16:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768437657; x=1769042457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kwQTxZEOGNZ+MI9z8E7dyWDZVVqYLa/Ly/GOaJt7Wk=;
        b=KDXEEx4HbCtR2wXGG6x+bNeT7NM3DSh71Fg33fdL/Uedoa/R/bFHucuHy5IbbMZUfI
         9KFCrLiGWUv8uV/sMsJBXIhY/TQdi4w9sm3YK0dmTlsWmUCxyiGBPROHUISpFQtrXwUm
         hSRjPDUis7tz5oYSZukv+bAHilQAHuDj4LZ0c4hf2OabTE71xJx0PTXkg2nj0fS2pYnQ
         xPySq95Re4ynvw2CrxS5lHCbCj3NBiS/b9aljrGfa/OaxXYhtPcGlNWhss5Ujcx2vgj0
         unFjI0jkNWEiWHMTnpeno8X5lI7auG0FbYiGcySmtpMW7aBKum6WWMtsUD22LXVZ9tN3
         saVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768437657; x=1769042457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8kwQTxZEOGNZ+MI9z8E7dyWDZVVqYLa/Ly/GOaJt7Wk=;
        b=NhZfRscChp1e5HkXNiD9auulOAS2qwVFsieH14HUxAcnVgjJCKJyo9SCQTT/kXRZa5
         wu7nujcfa+Oi8MnaOGVGRyKA91cYzX/dqYF7xGDMsgGz5QhQJ2QcphsbV0QhT9iVNroi
         /FEBvSKp5vEGBzrrYHNeoDsAN0CqwFEIJez0Wo+Ja1y7nxn0kd3G2zdNfjUSuxTarpzT
         Ep48vED5uhXxpZICoWJswUp0BnmXnY0N+ufaNoxNUDpJ2qcZgL2gA9y0uGY9gnTNQi/F
         KkDhwKfYBQJG1vE+YB4q+G5fYgFkWLvmm6VXTzuEU3pWOOtBTqrhPNBNUSTZba5/YHln
         utKA==
X-Forwarded-Encrypted: i=1; AJvYcCWKBKZVFniA5G/2Lvdd3pupnLeDMJuHusj5+X/p4ecQELIpdGq1tFS9+n1QgKUdLUz5hmvoHKncLYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBHleGuhznfpPx+fE6e/ZyIUiXmobEpNHbn95P06deTIu4ZTmX
	W3L8BJb6nguwiArDeniu9/4QyeEWaAg6VXY/D0AEigykVbgT4H75sR4HHmhDcQN8f0/RMYI7VeE
	U/w3oh9aFdMOB8RiZ3lcYq8neonFRPcM=
X-Gm-Gg: AY/fxX4HRU7DhMDhHvy2o40m1ZNp4o/kGc8EPjFZ0Uuz03QeTriUV76I/4avOGxP0e+
	yVcNU5LcW5BwEseFu0aeXEWU0QK+JoSxYbCjpRFrqhASJjP5JFa9sungeBAAoXBnkfGFjkNR1+U
	KK3UTByszD5w2FnwOuJFjKmLMobjm3l9GNamjpzmPHQ1oSQANdT9vGQl//PJSsl9wGsM2+bFMmR
	8INhMMySuX/gSjMd5Pv6GlpqEWnOaMq26zOe2P17TMR1TaZ8agZxevjvInlV++XdMR4oS8LV/t9
	FdDKNAA1ZkOnOFaIla34mMM=
X-Received: by 2002:a05:6214:19e9:b0:880:88cf:59ff with SMTP id
 6a1803df08f44-8939813b73dmr21430456d6.22.1768437657315; Wed, 14 Jan 2026
 16:40:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113081453.8293-1-akinobu.mita@gmail.com> <20260113081453.8293-4-akinobu.mita@gmail.com>
 <aWZLZzo5Hb1aFZ0j@tiehlicka> <CAC5umyib=XmPkTvRT6eAsMx+WDx0NkSP9djh4xkhLJgwk_v8Mw@mail.gmail.com>
 <aWfXHKDzoQBsHxAp@gourry-fedora-PF4VCD3F>
In-Reply-To: <aWfXHKDzoQBsHxAp@gourry-fedora-PF4VCD3F>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Thu, 15 Jan 2026 09:40:46 +0900
X-Gm-Features: AZwV_Qgg18kLLSG8crf76_eOaHbqkvkT03IVgWC4bh_s308ae0riyhU-hM237pI
Message-ID: <CAC5umyg+wubKoQSfpDQvNh3K5Y7+iOEYn6_BuKFd53kHDVE7aw@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm/vmscan: don't demote if there is not enough
 free memory in the lower memory tier
To: Gregory Price <gourry@gourry.net>
Cc: Michal Hocko <mhocko@suse.com>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	hannes@cmpxchg.org, david@kernel.org, zhengqi.arch@bytedance.com, 
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, 
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	bingjiao@google.com, jonathan.cameron@huawei.com, 
	pratyush.brahma@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B41=E6=9C=8815=E6=97=A5(=E6=9C=A8) 2:49 Gregory Price <gourry@go=
urry.net>:
>
> On Wed, Jan 14, 2026 at 09:51:28PM +0900, Akinobu Mita wrote:
> > can_demote() is called from four places.
> > I tried modifying the patch to change the behavior only when can_demote=
()
> > is called from shrink_folio_list(), but the problem was not fixed
> > (oom did not occur).
> >
> > Similarly, changing the behavior of can_demote() when called from
> > can_reclaim_anon_pages(), shrink_folio_list(), and can_age_anon_pages()=
,
> > but not when called from get_swappiness(), did not fix the problem eith=
er
> > (oom did not occur).
> >
> > Conversely, changing the behavior only when called from get_swappiness(=
),
> > but not changing the behavior of can_reclaim_anon_pages(),
> > shrink_folio_list(), and can_age_anon_pages(), fixed the problem
> > (oom did occur).
> >
> > Therefore, it appears that the behavior of get_swappiness() is importan=
t
> > in this issue.
>
> "It appears that..." and the process of twiddling bits and observing
> behavior does not strike confidence in this solution.
>
> Can you take another go at trying to define the bad interaction more
> explicitly? I worry that we're modifying vmscan.c behavior to induce an
> OOM for a corner case - but it will also cause another regression.

I agree.
It surprised me that the behavior of get_swappiness() had an impact on the
issue, so I'll clarify its relationship to this issue.
