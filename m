Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADE7285050
	for <linux-cxl@vger.kernel.org>; Mon,  9 Mar 2026 06:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773037641; cv=pass; b=YHw2b9GH+J4Jq3lxsY7PP9dHmXYVjc0PVsVG3r22AUyg6FfcW+JGE50AJmktiFHW/g3JV7yrn7WQqTpMfLE3Tj2mK7uOdg2fkgSv1/kQ5FXYIPRf0w3/8DgBpVpHv61aOvDc6bdSqf9WAnaxFlFla+xeoC1P8jgggP+yXCKvSKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773037641; c=relaxed/simple;
	bh=tWJ/fX3Ckxq4WEzhukQr0K7T+NWwaaBTCqm8O0qx06M=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ko9Vw8Q93fRkwULIqITi52f5xGSZmWy2BagCJuUC+RftKoUJWieuaT3DNGB6Z4Uyr+EY3QlNOtrr5VEyobHpx2EnR0J2TCuyU0WCMhoEI/29+F54Npz8/hANRatl/IfR8XZgBd388zvtYZcKaAib7VRgjhu9CmkRAKhCz6NYgMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3H5gmW8p; arc=pass smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3H5gmW8p"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-5ffa0b23a60so1895366137.0
        for <linux-cxl@vger.kernel.org>; Sun, 08 Mar 2026 23:27:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773037639; cv=none;
        d=google.com; s=arc-20240605;
        b=N1QFJpbEm1opwaeei3gk/5DXlAnoLy3UwjcpXN6g9syyHo7XhC1LklBTVTVtvvvhOV
         8m4VmARVDqWEOJS4LWE3UmtMa3QSGhiMgXWl8kI4gqLW7zFLeB7+MyFWxnx2sjZnf09N
         yB2dmv/M/zjCI6mUhpGd5aDccqwT9vFG1bb207Ro1arM9wV+mCjgbHt9SQZ9wuoIMODc
         yGqKw0dtKDkrJ9ljGD62TfIYAFFyA/eaiCWkIp20kaZm5qkRUT8z6sWPD1yxM03NUbLf
         VfS/jzIU6DaOxVzbWk7GQMGoOVYSB+ZBtueHmeBD/pKxiqkEWWnnPp5sqXBP5bSBKR1W
         NrGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=uthJSqpDGuue4aeWUw9ODMGHbGatL8hg/W+VDtshmKs=;
        fh=3RtJDFO94OGbhJa1cNVNg+fR8a8bwPlhq/f38U9VylI=;
        b=d2Nl+jHRD3iFGY+/3A4941louL8mYpazqMCbu0VneudqwYOwEi5TfxFMaqd8njV0Ap
         TDjqLyOwtrQpbeCAA8MPZF9nFQ/pGV2vzLznd0AbZKQ+tlX6Q7fqkfIEDvJiLLU0ePuP
         Hx4UnIzd82D8dd/bYA6QaN9w7FxVB//6x/QoujmnGjYEyIO9gmkSrwMfl8iVXRjFoD5P
         zQIyBHU+giSdafy56FofBK8Vkhh/ZVKvu7imMkk4ooVQopwU3GSbKdbIZ1SNuGvAi3SR
         lJcIx5G69cALmoZ1FUh+vbLFufUUBZywAHb8vDnaQLlqPTmbxHe07YP7V3RFcViOzSK9
         THzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773037639; x=1773642439; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uthJSqpDGuue4aeWUw9ODMGHbGatL8hg/W+VDtshmKs=;
        b=3H5gmW8pbkQt69icUXiv31N0ppI1uLaAEqyifhieISaamd2DQXxiSdiw/bbIO37SVJ
         X1pBQSNU7GI+tUOy3+b4aTGzxu+37Yg+1+4vv6t3twVSI6jCIlg6f9zIdu2T9vIQNej6
         hDiMmHWc+VrL2Q1LFkpMpRic9ARbdPSQNGqLtjDDJtDp/jTb2IVWiFff6tbb4dFpqSE3
         GfcNHOufsmcO/76Ul1Rmq4dfLvocgx6k6ypYW7G1i9D83/T1j0Nt546VOkwkp5DYT782
         gxfv/MpWu0oNlbuw/J1gkbumfoNooYyAC/quLQ2OyfmxIrG+UFcfLuhHwfIzX62eAMdj
         6StA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773037639; x=1773642439;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uthJSqpDGuue4aeWUw9ODMGHbGatL8hg/W+VDtshmKs=;
        b=B+GnYneZuKyS5XcdU+jPftGkE0KwI1tQWGJMXSxN3mhzdA6U/kPFL7o0bAjZOhEfM0
         ylstlBB4gBgLt18L5e7kwoGBwqZpGcFQQTUYl98qjuB4/upijOzHuc05hoCoej6CqTJt
         wzx7hqVQDBV/1eDFkVHgMgqzx63O987e8NPgyHcpvhpW+FPZdnmewPmiktlTaFNeRtUI
         g/EJtnHAIkRNgjLPdS45O8HqDmGIPLj+rx79z8SQlHQ4wmEZLxoi11/BVSCgEPfrMt1V
         iaQde+ktvbD6CJd2XfbpyQlieOcvnsgNDkfGkUP9lS4hUo0w0BXJJ1U31CgMfqmB7fcC
         YBfA==
X-Forwarded-Encrypted: i=1; AJvYcCV2zH4e0wgOtsf6YmrVu0+t0aqP90wvWLuIgxlxs+yyBSi55/MMtrJ4vX3w449Vh7BXUBXN7Glbae4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwtYRes5UCFKnxu3+zyvB1NnxCdWRbE9vseChC/7cReciAxFsg
	q+3/XJOs6fa388WxdF0c7bdyG9I4kh8uzb0CVvlzOqofo0X1jfJ0qyrxQIL09w3/9Zdui1IteMv
	jpm5zQAVMAU8wP93Ne7dbPebHib7lgyU1kmUk7beE
X-Gm-Gg: ATEYQzw0I5yEYYskmgZ6JOo4djxqcTm+EL0o8zfpduKYuO3hAH/VMM3zUxuqW2a8im+
	m9gwKCQXzzO7IKiqEgMp+IdJSdtQvKPyNX17aNgrTRtlYgH04GSnlQ7X8utwCma9AMc1DHSMXGh
	ZMzDGCUs93d5tls4fEnRaceflya3aqHYsW6R24piwvzFK8DI0IyirlB5g633O2xQsq8g6BZIJEV
	QYIG4ADl5atyZIxQAWmwIWdj7syoOnd1kdMcub70ZHV1W/gEG6ZMaqhWL157K63h/pebvVFKUxd
	2UVrZW/glZFsv6OXWReEtBPOnWCmI6Qb/+nSAH5lf49cmCJHbnW9c6xltyIBsdVl4QkqtQ==
X-Received: by 2002:a05:6102:c01:b0:5db:f920:fa9a with SMTP id
 ada2fe7eead31-5ffe63cdb3fmr2925679137.41.1773037638925; Sun, 08 Mar 2026
 23:27:18 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 8 Mar 2026 23:27:18 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 8 Mar 2026 23:27:18 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <aaWlxFh-bqUYXgUo@groves.net>
References: <0100019bd33b1f66-b835e86a-e8ae-443f-a474-02db88f7e6db-000000@email.amazonses.com>
 <20260118223110.92320-1-john@jagalactic.com> <0100019bd33bf5cc-3ab17b9e-cd67-4f0b-885e-55658a1207f0-000000@email.amazonses.com>
 <CAEvNRgHmfpx0BXPzt81DenKbyvQ1QwM5rZeJWMnKUO8fB8MeqA@mail.gmail.com> <aaWlxFh-bqUYXgUo@groves.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 8 Mar 2026 23:27:18 -0700
X-Gm-Features: AaiRm52XcCdEx1v_REqqEWCzJAbxKWYQSWfQ7emIhDTUFVwrkCx8Utez8oZPcxo
Message-ID: <CAEvNRgEzb6Ux+iVFT=F6jc_R8V=LTYCigHp+yaHFkdrX82-yvQ@mail.gmail.com>
Subject: Re: [PATCH V7 02/19] dax: Factor out dax_folio_reset_order() helper
To: John Groves <John@groves.net>
Cc: John Groves <john@jagalactic.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Dan Williams <dan.j.williams@intel.com>, Bernd Schubert <bschubert@ddn.com>, 
	Alison Schofield <alison.schofield@intel.com>, John Groves <jgroves@micron.com>, 
	John Groves <jgroves@fastmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, David Hildenbrand <david@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Darrick J . Wong" <djwong@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Stefan Hajnoczi <shajnocz@redhat.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
	James Morse <james.morse@arm.com>, Fuad Tabba <tabba@google.com>, 
	Sean Christopherson <seanjc@google.com>, Shivank Garg <shivankg@amd.com>, Gregory Price <gourry@gourry.net>, 
	Aravind Ramesh <arramesh@micron.com>, Ajay Joshi <ajayjoshi@micron.com>, 
	"venkataravis@micron.com" <venkataravis@micron.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>, 
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

John Groves <John@groves.net> writes:

>
> [...snip...]
>
>>
>> I'm implementing something similar for guest_memfd and was going to
>> reuse __split_folio_to_order(). Would you consider using the
>> __split_folio_to_order() function?
>>
>> I see that dax_folio_reset_order() needs to set f->share to 0 though,
>> which is a union with index, and __split_folio_to_order() sets non-0
>> indices.
>>
>> Also, __split_folio_to_order() doesn't handle f->pgmap (or f->lru).
>>
>> Could these two steps be added to a separate loop after
>> __split_folio_to_order()?
>>
>> Does dax_folio_reset_order() need to handle any of the folio flags that
>> __split_folio_to_order() handles?
>
> Sorry to reply slowly; this took some thought.
>

No worries, thanks for your consideration!

> I'm nervous about sharing folio initialization code between the page cache
> and dax. Might this be something we could unify after the fact - if it
> passes muster?
>
> Unifying paths like this could be regression-prone (page cache changes
> breaking dax or vice versa) unless it's really well conceived...
>

guest_memfd's (future) usage of __split_folio_to_order() is probably
closer in spirit to the original usage of __split_folio_to_order() that
dax's, feel free go ahead :)

For guest_memfd, I do want to use __split_folio_to_order() since I do
want to make sure that any updates to page flags are taken into account
for guest_memfd as well.

>>
>> >  static inline unsigned long dax_folio_put(struct folio *folio)
>> >  {
>> >  	unsigned long ref;
>> > @@ -391,28 +430,13 @@ static inline unsigned long dax_folio_put(struct folio *folio)
>> >  	if (ref)
>> >  		return ref;
>> >
>> > -	folio->mapping = NULL;
>> > -	order = folio_order(folio);
>> > -	if (!order)
>> > -		return 0;
>> > -	folio_reset_order(folio);
>> > +	order = dax_folio_reset_order(folio);
>> >
>> > +	/* Debug check: verify refcounts are zero for all sub-folios */
>> >  	for (i = 0; i < (1UL << order); i++) {
>> > -		struct dev_pagemap *pgmap = page_pgmap(&folio->page);
>> >  		struct page *page = folio_page(folio, i);
>> > -		struct folio *new_folio = (struct folio *)page;
>> >
>> > -		ClearPageHead(page);
>> > -		clear_compound_head(page);
>> > -
>> > -		new_folio->mapping = NULL;
>> > -		/*
>> > -		 * Reset pgmap which was over-written by
>> > -		 * prep_compound_page().
>> > -		 */
>>
>> Actually, where's the call to prep_compound_page()? Was that in
>> dax_folio_init()? Is this comment still valid and does pgmap have to be
>> reset?
>
> Yep, in dax_folio_init()...
>

On another look, prep_compound_tail() in prep_compound_page() is the
one that overwrites folio->pgmap, by writing to page->compound_head,
which aliases with pgmap.

No issues here. I was just comparing the before/after of this
refactoring and saw that the comment was dropped, which led me to look
more at this part.

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

>
> Thanks,
> John
>
> [snip]
