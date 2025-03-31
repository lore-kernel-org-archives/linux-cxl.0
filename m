Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010CE126BFA;
	Mon, 31 Mar 2025 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743442336; cv=none; b=Fvr5iaBTudRjzBfbBciMKComQNQhiw2pSekvfLWI3W7NP8+BqrUccBjMCFr7LLbRqw8E322ACiEp3/2fJE/g85wWXtnDZr+/dTbrdCVmxlrq8cq7ilWgZvg4kMAcd/+6YvhIuvpmyzIIsi3CfOAM+QPQVWivFNQHMHU/04IdFSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743442336; c=relaxed/simple;
	bh=zySoybPr1LS9gCbTUTDnbZKO2E3W6qo//cfUHqXvqPA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W0x0ncXOLGPaQZI8fwM5KCJeMS3X1dmxkAzibGDEVYnCiuUaQZt3teFHNROG5AnsTjKFuWvsL+U37wVZa/bKLhT0WmNxpZZBC9iNWM+QQ9838b9e7mI3XxXCsXDJ50HOPnJBgxGOs/HiYmadiXvjaOOJZZh1NA7Thfc1U9BX0P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hn2oRuto; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hn2oRuto"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-52413efd0d3so1954443e0c.2;
        Mon, 31 Mar 2025 10:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743442334; x=1744047134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zySoybPr1LS9gCbTUTDnbZKO2E3W6qo//cfUHqXvqPA=;
        b=Hn2oRutogl8qbBuTGm/ej9ili1oV5qo3WxF1XiONqlzv6Q4aDOf9bEO/geGujdO8dE
         tmyxtftHYgJAudUakYYYgEdvJJ7VDSZfph8SjfZUZzyZQIEYawRstL3f6wy+K0lQf4UQ
         0YYNR6CN42nW9qSdDMfccYOx8qJh4f7qM05lIkNN4S4W1ZrJRmusQE4y4yUPvlpT8Ar+
         7bWl89DsvzCKdLQuMiNknG9jItpHOSjKB5gTCnsOZeyOXemGNKM/oc+OATHjD+o3gWEC
         RhQGpL/xT1Y22hogEimm5u/ysiCYJR+8rgicFJbO8GcpGUsaskXGi/WvZ5wHs1uQMA9F
         RFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743442334; x=1744047134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zySoybPr1LS9gCbTUTDnbZKO2E3W6qo//cfUHqXvqPA=;
        b=OG4v0Q4/nNmQEHyDFN0SE2EJhUPBUi5iniiSJPRXJQI2KJhgKNvbdpdP/xnTpdvKjc
         x86AnwSwPI0NLoNS2lLrgsgiKiNGlbfSZI4JPHzbhPVhvth+LKl+lCndX96eJ/y6QLNf
         d7tEFWWoprvlkh8eyl5x8LojWzK/hoQxxJ2yH3DH39aPU4nWQ/z6PfG44xETKYbEzcMI
         Er4Zqo8u2RlE1bD/G5UqYBnIN1UAhFviTQ3gGmVB+tnFSJfrnZREwDOxJ611SUPWNegG
         9Q9yLyK6DL1QQvt6NGga/e0rPFKu7ObfKeHfpNrcUuThwDECYuHX9DpBxLO1ntstBrb3
         7lJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlWxYYBvkqhiyndYmu5UnMcv1CZsKS31YuoLfi8d/HoFuNzfPN/rojEeXWQwPnFEZOcMzt5dZDZjJTsRwm@vger.kernel.org, AJvYcCX5mW2UXz0/emJCtJfyrsGF6gxUTupUMMQE750Ys+/mtkCvqdBjwBbQ2LfaPMWbI4Ugz8wkXQeg21A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrbSkISQr5hhqm755TyEc1fMfdmzClTebsJ/6Pcp/8nQS4Cnk9
	apeNOVsWRKeqDNPzimvcEX5wj+b0qKVw50zus4W246gpEpOpUblFdEp562nc0aTylgXtmPuT60g
	M4oY82ZYdYwZstxK5eGBz0xSJcf4=
X-Gm-Gg: ASbGncvfQUqrDIi5mJ6PvusBTkjZ13ZPJyFl/KJsV7lDC0nSJQjS9jPS02dcPUIHgLK
	nZVoNxSEI3oQKjRKGfQZlp0j4GWFgoLimA6lK6fvBNdG6xCf66pkNsYENcVgSEwvHGAoR57XmFp
	ndmrK70kSFYxi1t8ej1x9a4QgjzOqA2rS99pL7jQ3hYmVkTabsORWn
X-Google-Smtp-Source: AGHT+IFRt7nEawEZeSSAGR/c7AAI9W5lRTtFBUHzbaU2PE6O+vekjVBeiEfpVtBmNdr2HXdWKp1eXSD0GadA5yFaBwY=
X-Received: by 2002:a05:6122:50b:b0:526:7f3:16e0 with SMTP id
 71dfb90a1353d-5261d35fd7amr5348864e0c.1.1743442333680; Mon, 31 Mar 2025
 10:32:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250329110230.2459730-1-nphamcs@gmail.com> <2759fa95d0071f3c5e33a9c6369f0d0bcecd76b7@linux.dev>
 <20250331165306.GC2110528@cmpxchg.org>
In-Reply-To: <20250331165306.GC2110528@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 31 Mar 2025 10:32:01 -0700
X-Gm-Features: AQ5f1JrIIZgKp1cRUxc-JOkq-RdPa2Tf7EGPfmg76yBDjQaf_dXAo3NsY6ZhY-U
Message-ID: <CAKEwX=Nw8PZYKd4TcC2+VW7URzT67aM0wJyYMu5X01ngbFO_Yg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] zswap: fix placement inversion in memory tiering systems
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>, linux-mm@kvack.org, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, sj@kernel.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, gourry@gourry.net, willy@infradead.org, 
	ying.huang@linux.alibaba.com, jonathan.cameron@huawei.com, 
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org, minchan@kernel.org, 
	senozhatsky@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 9:53=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Sat, Mar 29, 2025 at 07:53:23PM +0000, Yosry Ahmed wrote:
> > March 29, 2025 at 1:02 PM, "Nhat Pham" <nphamcs@gmail.com> wrote:
> >
> > > Currently, systems with CXL-based memory tiering can encounter the
> > > following inversion with zswap: the coldest pages demoted to the CXL
> > > tier can return to the high tier when they are zswapped out,
> > > creating memory pressure on the high tier.
> > > This happens because zsmalloc, zswap's backend memory allocator, does
> > > not enforce any memory policy. If the task reclaiming memory follows
> > > the local-first policy for example, the memory requested for zswap ca=
n
> > > be served by the upper tier, leading to the aformentioned inversion.
> > > This RFC fixes this inversion by adding a new memory allocation mode
> > > for zswap (exposed through a zswap sysfs knob), intended for
> > > hosts with CXL, where the memory for the compressed object is request=
ed
> > > preferentially from the same node that the original page resides on.
> >
> > I didn't look too closely, but why not just prefer the same node by
> > default? Why is a knob needed?
>
> +1 It should really be the default.
>
> Even on regular NUMA setups this behavior makes more sense. Consider a
> direct reclaimer scanning nodes in order of allocation preference. If
> it ventures into remote nodes, the memory it compresses there should
> stay there. Trying to shift those contents over to the reclaiming
> thread's preferred node further *increases* its local pressure, and
> provoking more spills. The remote node is also the most likely to
> refault this data again. This is just bad for everybody.

Makes a lot of sense. I'll include this in the v2 of the patch series,
and rephrase this as a generic, NUMA system fix (with CXL as one of
the examples/motivations).

Thanks for the comment, Johannes! I'll remove this knob altogether and
make this the default behavior.

>
> > Or maybe if there's a way to tell the "tier" of the node we can
> > prefer to allocate from the same "tier"?
>
> Presumably, other nodes in the same tier would come first in the
> fallback zonelist of that node, so page_to_nid() should just work.
>
> I wouldn't complicate this until somebody has real systems where it
> does the wrong thing.
>
> My vote is to stick with page_to_nid(), but do it unconditionally.

SGTM.

>
