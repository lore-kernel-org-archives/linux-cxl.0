Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6763A9637
	for <linux-cxl@vger.kernel.org>; Fri,  2 Oct 2026 17:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790963248; cv=none; b=Xpni9BjIJalNQPgwmRR6nAsk9nCUo7Ci+lxAFoHFcx24NPzP2mtAocnSTz1eWK0qR5TyJDefGPrVTcwsFnIK/KtAHaMSaeHOVEBmd5YRrU+sIAdQl2TtA1jVHdEa0HD4I/LozLCUQn79tOETcNhiFoMqr3YDqdC3sVOUAmJyx+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790963248; c=relaxed/simple;
	bh=X7pKiKO9QsXYnM+mGnwA/xp96f3O+0EntAaPIkSPacw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHufyNEzV7a/h62BLBV0BTvyGVx6f4VIVMwL5qKVuKqmEVPI5tC30/PWvc2shffhZDHoix5Q5z+U+9mBlBnByuAKHu3Yz01jFwPMqkod9Km6b8Gj0IXG+t+mBjbGiSHm9mZp4Jbeweyr5xDw3pqVVPGbZTqiJbb+PizRozpncrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ZNADCt6t; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ZNADCt6t"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-488811c9ebaso91546f8f.2
        for <linux-cxl@vger.kernel.org>; Fri, 02 Oct 2026 10:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790963241; x=1791568041; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BsRwOVo297ZhJSI5g2vm5Aad4ipR9uH8sT9viLQ8JQ8=;
        b=ZNADCt6t/H7jJZqCNi9Q03JBp1oq96HYBDnuvd0cE1CTsrRE8Da+eknjRLYaZu/rpj
         foTB1K4e570Tzbp6edbK/dHrfY+o4e3SW5N7wlWDRCNT+dIrUZPKFZvYDQSCtM4T74BZ
         ESwOEOl21bGpvmcEstX3BpyAH8ZLsSqI9csu6C/KHBb3X5IlooRTgoaZtQc7wnXafKLu
         feFQ3vbSHdfhGGbkPeOaP/GVBUYa0jh9thAY/qeiOfqPWMQP1SthdU6IOsy/uBGTYz3j
         5Q/RYhZ0Fh2VMPdQB5EbBiFumGhcTLICpMP4cOvNMFi+oHsbAlkXiUeB+kccEb4Vyin5
         iGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790963241; x=1791568041;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BsRwOVo297ZhJSI5g2vm5Aad4ipR9uH8sT9viLQ8JQ8=;
        b=MoAA0hN1IN94J321k+kmj/EORf3gzWD/BSWqI4HJ5uu3tqlcTF1i8FWUm1+loeNtX6
         XkzHqftiAJUfLdFI8FfnKPxl2aZjoV8+NAAT9Nk788ntglggqoHqi9LodrQ7RdcPKOvS
         eJZxjNlfNQOtMKJw2u2QvTrmmx2ZhRY1ZRxLdiI0IUtKVsgM4yFNaZIHLh6131dUB9zp
         DGd1crkm8Xl26eSKBcOLUEfKXuwkDomUy5KQv/I2CerDSYAL/Q0frfMmUl8Q42GP/LcO
         DDeP/jWWF9c3+sVJitQhe4ptlqnWzJX1Npq0reCkH8r6fpqA+819Nz4cEhul0eS9ZP7+
         07eA==
X-Forwarded-Encrypted: i=1; AKwUvBxwzBqj1qWp/vRjxgxrfU0j1XhrvuSfwl+pM4lG/2WlUg9eMlGCumZmUbWsdb1NiPUWIWI1zYyTDgY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKJ78kVXLufLu7KAATj1IxV9CkVrr8kQV4n/TZBwAwDMGR94MxA
	hHbZ5l8nw7Gdqu8JQShUM68p0F77FK23hLxSoV/JOQqWL03be+LE2rCZJs/i0qOl3xI=
X-Gm-Gg: AYBFou2hw+RI/LsuVeduTIJvF1WVJ2TepjLJ3pSyJ4xIVlQGghz6On8nAVPiPf+KM6O
	cupIW1EBblQWu+7f+U1r4XAAhcYGy9VnjeWQ+Qh1uAi0rnrb4mvTHb72/TStE4IAANRc3ov7WqS
	HWBFGJHk07xd8OIV7WCMFw77uUwPw0aA8586QAAiHaOnlXRwnrmzAMfD6pF460EEjpzNMqCPhv8
	avbWRxlCD03LjbFe1MYPb2yrzju+T5Cl3aQjKFO6deKvucAJTViHWLc/wAY+i7I5VKanYqaM8sQ
	RlLf6DZGPo4i8lVRN76NIsPW2Eq261IvOiNw5BzI/oWAHnluekWhjLnwlfmfQZfdls5d5z1D5ea
	IpDEPAmSucdZVhexZJoX5QJIcXYhPWmy2HA15MgTFGnsUC+whXu3JgqjpPZtRTUf1d4fc+D/Nw/
	Agan37+sKPmLSRqp5yHaShavO4EeFK350hv+edDAUDXjXbSKPAyiFx9QyLmGfyfK/nPZk=
X-Received: by 2002:adf:f108:0:b0:48b:e50:715a with SMTP id ffacd0b85a97d-48b1273e612mr4581767f8f.34.1790963240679;
        Fri, 02 Oct 2026 10:47:20 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F ([2620:10d:c092:500::7:9b19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b82253dc9sm6964307f8f.3.2026.10.02.10.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 10:47:20 -0700 (PDT)
Date: Fri, 2 Oct 2026 13:47:18 -0400
From: Gregory Price <gourry@gourry.net>
To: Anton Gavriliuk <antosha20xx@gmail.com>
Cc: linux-mm@kvack.org, linux-cxl@vger.kernel.org
Subject: Re: Poor memory bandwidth performance between NUMA nodes
Message-ID: <ar_rPzLhXRSA0AfS@gourry-fedora-PF4VCD3F>
References: <CAAiJnjqz+OB+PmUQBENS8ThnWHSAFK=p3EA7KPsy5UeabQCn-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAiJnjqz+OB+PmUQBENS8ThnWHSAFK=p3EA7KPsy5UeabQCn-A@mail.gmail.com>

On Fri, Oct 02, 2026 at 07:16:12PM +0300, Anton Gavriliuk wrote:
> Hello
> 
> There is Fedora Server 44 (up to date) on HPE DL380g10 socket server
> with Optane PMEM DIMMs configured as system RAM for simulating CXL
> type3 memory expanders,
>

Couple things:
 - if possible trying onlining the PMEM in ZONE_MOVABLE.  This may
   help avoid kernel data landing in PMEM which would be very bad.

   If page pinning is required, then this will likely not work as
   ZONE_MOVABLE pages cannot be pinned.

 - Optane has like a 3x worse write bandwidth performance than read,
   so expect it to be significantly slower.

 - the stack below would suggest it's likely the folio lock.  You may
   want to check whether the folios are being pinned and you're just
   hitting a wall because of the temporary pins or some other contention
   on the folio itself.

> 
> 48280162400 lost: 0/0 drop:
> Overhead  Shared Object                      Symbol
>   49.82%  [kernel]                           [k] migrate_folio_unmap
> 
> migrate_folio_unmap  /proc/kcore [Percent: local period]
>   99.52 │       lock


