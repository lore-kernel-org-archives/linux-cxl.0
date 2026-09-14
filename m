Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B730747ECF3
	for <linux-cxl@vger.kernel.org>; Mon, 14 Sep 2026 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789396707; cv=none; b=bOsKoO7krVsfP2Z9TtB1JTbgJATumesA2N3LfL5AQz7dP3a07c/tVB3V/LEUEBfm7ocWescG5md/OFjHgUirUCMRROZuse98/+P0jejDoLjo63fgjkCO6oLgXUA6PijADj/BolTxf9NKB6KD+3mH4O1xN92AXVtKbOspFBsYxX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789396707; c=relaxed/simple;
	bh=TtHTqL+UFORJacBemcx0LNXtW0Z0/+7lM+21HB24SRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpOzxCzCsyTxYQF7yyuU/xBpcH9l3osCaiEuevC04qNtPywobO6XBw9UayJtv9TrF0kc3hmkA7cM8F/I4IGVvu0mBV3gJjPIPXfcKZtTpTzw1NeFHVX1FgjUqIyBJC8a5Zv0sEL3m0J/cZT1zdJ5YoPKPyC4z4wTv5Nl53od+6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Daqay4nY; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Daqay4nY"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc6db0aso28027816d6.1
        for <linux-cxl@vger.kernel.org>; Mon, 14 Sep 2026 07:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789396704; x=1790001504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TtHTqL+UFORJacBemcx0LNXtW0Z0/+7lM+21HB24SRA=;
        b=Daqay4nY2s6tbkXzJ0vN4Ka+1kIEYnajThgzwV8fysYG7Ac7jm5swh6CAppt8rsTAe
         Vaf8nCTJFAqGhnjETEJJMQFpJuT4qkhJmO6wzJD32l5KyWMhGELxeiyezO9n4BwAjFxH
         dlWYGyZDjxzh4kCWEMQhKIMJdp2zFU1wzoPRmccHq5ILsT23a6B64PfTZKgjuz97F1wi
         9M9BBJF2ne4kR0x/+5qikJ87Gwv5TQuhx94YmcwSdHO5lCTsMKxzpA3ks6ZnYiYzSKlo
         v/hkI7yMQy20vYVOze/cYbbJGyN//+9EjrQX6qqq4ro4EiJUvybo1ZNh+qwcfmXF0sIN
         DUqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789396704; x=1790001504;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TtHTqL+UFORJacBemcx0LNXtW0Z0/+7lM+21HB24SRA=;
        b=sYUkJXlEtp4mmQMwLBfOxz1oU4dx/dbboXA22SoK/F748AmB6YJg+sg/4toInTc5gC
         7Zby0rH7RBG/dQc3orDyz4Y56jvyrunWVQTwt+alxLvkTm1yhoFtVEtIkZ3hP7u8VlgL
         80U78/mpSbpp4g5ljziHDNvOEfEUiSRc8hbofmRhXPz6dugnNof18Mpj+dA/XQ3KRB79
         /5mzDw8Iel/ZUGUpyrzB6AW4aavL4ifPf8VWl6o4dipEGSnjPjPez3dAUo4pUq870H0c
         IqrafKe5OnXKdf7tYyDASQOdFQubizVaERjU1qcfIhJWrQ+9O9Jz5s7fUAoQAD79OREN
         T6uA==
X-Forwarded-Encrypted: i=1; AKwUvBzMA6PDpfOlF+mcNH/nsspS7TEum+Ib3KXQ2zv9OjS92KfqJihP8MkxLxQULDGAb/w283odksNf/pg=@vger.kernel.org
X-Gm-Message-State: AFuF++mR2r7hzHNJN010C8SYfbAb/wQMxPN8PTJ+NOJ5hQE8TGjr3vly
	D1qqTM65GCq++kOiI8//GqFM532zhYcNnqSKiK7rl3/0WWZjIGchIafD0n5+QJzhBf8=
X-Gm-Gg: AYBFou2s5qIc6Mo8s60geEDSSryVSkO0Wyicy2FQ+w+/FJqyOYNpov6BS0v1RaXcMTe
	zgmYgJD7vsS+67FFak5cwppizDTT54jsO9so+Gz6iTmw+wgpNDFI/mkpBGbpRsvnVAUs8BqPN+b
	kVAkcV1ItfsnYUKzPOEHK+HXjWftWdbJ6M4pkk5hl3QRZ4seL6c6MqDEszYzpPi+SHr20JQcAoF
	29x+bPGIxqaY/Fv+cJ9KnDWLdkQxe43B2FbO4hqpHFNM/chUqpjyWyvJ6xuINeB5RGCsXfZ8Koc
	peA77UBwlzYae7WmcpUvskvVQNST/eR4b8NfPaNGG8cF9xrkNPmtArJ6NCbfN0RYchTWAZ9PmZ9
	z6ndDroXQsA7VNSHaLk2uK/AQgDUyNl78Qc4YXeOokNNAjXAMXUGY8NGjtK2J2rI9co5hWUNYDD
	3ZSlJpIPBBAqTxlRlRp+GJC9lpL0F5D36rSFPMNIWSxEZyGCDm1NZ+dXUSmXa1DLzS8soeENe+m
	ufG1rB1vrAKfbyCr+SCIPMe220DBp3CoB0E9D1GuPl+wCuQoTnewII=
X-Received: by 2002:a05:6214:8613:b0:912:12cc:33d with SMTP id 6a1803df08f44-9122e552dadmr42040046d6.23.1789396704371;
        Mon, 14 Sep 2026 07:38:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f4d389esm95618176d6.42.2026.09.14.07.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 07:38:23 -0700 (PDT)
Date: Mon, 14 Sep 2026 10:38:22 -0400
From: Gregory Price <gourry@gourry.net>
To: "Zimo.Lu" <louis2665573906@gmail.com>
Cc: David Hildenbrand <david@kernel.org>, 
	Oscar Salvador <osalvador@suse.de>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/memory_hotplug: use public nodes for migration
 targets
Message-ID: <aqgGVIJwV9wt8gon@gourry-fedora-PF4VCD3F>
References: <20260914074323.3567923-1-louis2665573906@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914074323.3567923-1-louis2665573906@gmail.com>

On Mon, Sep 14, 2026 at 03:43:22PM +0800, Zimo.Lu wrote:
> base-commit: 38c7f48162aa282dc6a9edfb7011378594057c10

This commit is a random github hash from my v6 working branch that no
one cares to (or should) know about.

I haven't even RFC'd this to the list yet.

I'm happy to work with you if you have feedback, but you're getting well
ahead of the work here.

~Gregory
