Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEC878C91;
	Wed,  2 Apr 2025 21:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743630703; cv=none; b=ijH/F1EY7OjSglnvVw4XSouiYUuSZOvNbGqh4/E7xU3abkKDEfTzcGrbgc0Qfm8BlaX/X9teoOZgND+v4VmIdTaG+EVkuH7S/Ew4RqZSkixHRQ5FD9GIJStJVzZse9bJVSMlpnH+3l5prN87pUiJTI6E7bAKbPv7NfyoQ/jFSxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743630703; c=relaxed/simple;
	bh=FICI9pCH3MuJ0i+AnsWFEK9mn5iJqpqGuU41GdC/AOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hrCy7VtE+Mu+KVvu/RAtE1i+FjjesQSQp/zlolAjzusQVgPi6+38ts+PswdYjgSMvJ9nM76aQL1a+IxRKctVfe+ZtR0n4M5j3z2UNr7AJKZ1s/89+em3lROpB0momSwHnT2FHJVZPLWf/aUhYhhAFRybVyZuoUeCJGbEIjScBLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CO4vx7CH; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CO4vx7CH"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c55500cf80so17715985a.1;
        Wed, 02 Apr 2025 14:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743630701; x=1744235501; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FICI9pCH3MuJ0i+AnsWFEK9mn5iJqpqGuU41GdC/AOc=;
        b=CO4vx7CHkRi6sbhascE7wA38OpDo6VERrUihD2KI6PHaJZ5e+fHjmFDZ7MlvE5ceEL
         WopwXw6ntEUrba4WfO8xCBhT/e2trd4thrOmB3kA4tLJyvZutB62Erm+4Wnj5FtraqPS
         709OE89fLYol1oWl87qqpUskxoucYPqwckeRpkW0lDHwrgMBvXLE0CfkW1i5oJRfaEMw
         nwISc6tUNyyCe4/zrvNd5FJPgXGjnTgas8w6NOxBzXtazKItrn2m1XFfpxU+oAdGg6Y3
         g8K1Qzu79OAkf9ASY3Xo1KLd09gzdAHIUF4DZdbDho9MYTtj5ADRnDvLWvgl1+Og3UNr
         yn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743630701; x=1744235501;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FICI9pCH3MuJ0i+AnsWFEK9mn5iJqpqGuU41GdC/AOc=;
        b=JWLtJMLFeXg9zxbnkXUECMEzjrqtLz6lZMJFr1C67gwjY+fjZf78ZnsBxh8k3uKUwU
         7DbhR2JrNF+h28KnHXCcf4ARydl5LBF316/HuXWPeTIMZm3mTsIAtZH6XmYEJKY8EmZL
         RA7se8iHZuQWBrAp4tOwvEHPU8mkv3VgDFGJe28I7jxJiX0k3pUHEkP4xF0XjS24julW
         MecpPafUNU3kQXBMtzwKughatpXqU4HIGDrnHEDfqPRCVOTH8Ug77YNSeoC8DFkvs/vZ
         ahnTBeZSgABnwwYb8cC+jqPgeV9FFbg9E+cVtQOUjUj1PaihLsughOvNPCS0gFAHQpIZ
         J/Cg==
X-Forwarded-Encrypted: i=1; AJvYcCWqyUilaFrfs/xowSCV+EZAk+iSJ30GxQYvFgMxvIJmRVobjgzUtxlmmLUYixA+X+40PZ0JL/anRCbh501U@vger.kernel.org, AJvYcCXZv5am7mYKseGt/A4FIoRTx0nn8PzAXK90phgTKo0gUljl5M6vBl1l21wqeDKOpbVx6eacOZgzsdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgiQwgGt6Awhg7GL0hmkDKgokAUdy5k5t1OHClgQ5H9Ad1385D
	gKsjp0J6mHwvtDJYmOaWSBcXngQidPJ6XAS5lIffy3eKa+s9NR+pN6f2RYdXjofaFn/yJhLd7Ee
	8keElWnXjpaAi+psacpvPTTN3kww=
X-Gm-Gg: ASbGncvJg+Pic3F3DvucdY2LZSy8cQarqDYbTwH3TA+7Th1i1StemVKY2i70gyRvl0c
	ndKMALF1TCep8rHbsNluhRvNbFt/vznuxaLO9wBPSfHIiNHb3W8Cpa6YnKPAvinpbbdiYUf3fJh
	hN25eagodSaaN3XUkZF58Z88lS3g==
X-Google-Smtp-Source: AGHT+IHPYg4Hg3MUUg5pKFbqOTtvyAgJXtWY6laP6tEJVCK5sDjjWMzqP2aQGxYlLyLJjUwWhjea3Zqim7lQWQ7lu8g=
X-Received: by 2002:a05:620a:1da0:b0:7c7:62b4:91f8 with SMTP id
 af79cd13be357-7c762b49256mr669208985a.13.1743630700983; Wed, 02 Apr 2025
 14:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402204416.3435994-1-nphamcs@gmail.com> <67edaef8da732_1a6d9294e4@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <67edaef8da732_1a6d9294e4@dwillia2-xfh.jf.intel.com.notmuch>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 2 Apr 2025 14:51:28 -0700
X-Gm-Features: AQ5f1JpnbNAWmrE_n7rSW5zDGkArQI4_3QoAhEU6yCrIFbVS6YcXd-JP-CRYo6g
Message-ID: <CAKEwX=PBp4i4DmCf_7r+Sk6ekB9ckgZEpuR-x4f0CTc00-d+BQ@mail.gmail.com>
Subject: Re: [PATCH v2] zsmalloc: prefer the the original page's node for
 compressed data
To: Dan Williams <dan.j.williams@intel.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, yosry.ahmed@linux.dev, 
	chengming.zhou@linux.dev, sj@kernel.org, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, jonathan.cameron@huawei.com, 
	linux-cxl@vger.kernel.org, minchan@kernel.org, senozhatsky@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 2:41=E2=80=AFPM Dan Williams <dan.j.williams@intel.c=
om> wrote>
>
> Why do the work to pass in @nid only to hardcode 0 to
> alloc_pages_node()?

That 0 is the order, i.e we want a single page here :)

The node id is the first argument of alloc_pages_node. I made the same
mistake in one of the earlier versions of this patch series (which,
fortunately I did not send out) - hopefully this time I'm correct :)
