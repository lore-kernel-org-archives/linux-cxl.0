Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793868138;
	b=5NJK+Cy6S9Um2YkKD9+1m+vY/mz0j9teFIh7NkKL68yUIrWlGAJK22sFk3YRbSqvrQIK
	 qJ/BLZfZQlF+1gjwnnp0MIAIsriY/WZ1aaMZ630hACkLVRjiCVaTW4fAQnnb4YMFclmIB
	 AkcIuEbaqRrp+Bs72STIIIymRbraBDycCAdad23YlXLAR2elmwYiayoSBrjMucmkhV76p
	 GdS8fFnSCzLNtG0mI3ZTijc7n7RBSdyo/8wgtaa1YzYHeJHjmIezoYg4WdfJ2HMoFQCpL
	 ftNoiy9vDiAMz/7b4lF6RlQ8GV5iiGcvglAyhGFb63+kQMBHKoywtncPZiutVOqO2GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793868138;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=w8QMF44xZAI/w7QQkxFJCs4NzF+nECfSjG7lcXAyyG8=;
	b=ZFUvh4GH9Xc0eY9TlJ6Q+8+5SZ2DuO3q4Wn8/b7N5pj5DkzUofJHhYlvyAW+9pgJj+fO
	 Xn9UX1mMtN6rx7JO+JOybc9zs364ExpJkRUvEjrWWHEVsi8P6FyYBXoMfOjiUYpzVjEF+
	 Gp2zzd9qr/igxUP9i3B03d2wr7IKBD1HHNpb+ZgCYGlvUWh20+yB6xQ7dvYabIYDrtHCh
	 k0FJCGY1Nbzo1oDe5mdFm93MS0cpqnyuViwymUFkWU7948bJ8QJp785dCYZ1aZlMJRq0X
	 Y3MPGQYIHcCRK5eYl2RLUVb3wMapUyw+vLsXK2OD4EPSmZI7VXx4jKk6rc63UVXXNAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux.com;
	spf=pass smtp.mailfrom=korea.io;
	arc=none smtp.remote-ip=209.85.215.177
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EC4606A330
	for <linux-cxl@vger.kernel.org>; Thu,  5 Nov 2026 08:42:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2EC4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=korea.io
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cdadf7e248aso716054a12.3
        for <linux-cxl@vger.kernel.org>; Thu, 05 Nov 2026 00:42:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793868137; x=1794472937;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w8QMF44xZAI/w7QQkxFJCs4NzF+nECfSjG7lcXAyyG8=;
        b=p2slE8y0W8uoVNq2TmhgxeDzyGQ4BYyU/vH2pQm5e1qOAY6qJ6rYXi6A/kdzNESMLg
         dWk247qL8leoFn2Vk45rIzZUSEbx6G+ZpbzQ754UsvOcNVkHDShHlWsaTRJIIdaALQoM
         YG7I7Im6hfuzgjCIoshTHgZzad4p7MHwhBhc4SuSee/QlVXrwunMNMKwq9ocpN1bzvxa
         yuN4fpA5cckfT6OUNx6xvhTTVIWqVf+VK9xfgLpQooMG++w6d4VycGicawk69AZd3hc6
         UD3hgnjf1MLMIcQaKIyRr04cx59Zbo+HeZWXBaGBwYqB3c4UthXERLtfO3duIE1lrX5U
         0hZw==
X-Forwarded-Encrypted: i=1; AKwUvBzL6P0B7iD6jIjELEwpkODKvH5QBJ1GP84THqfOSi0LRFrkmiQgUdLzLefruFJXwjNvyeGv1YDvuKg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8sK9BpIbxKWMk2G2WVXmluUnREsfZNQlnAexDmuRzw/L8rHQ4X
	wPXYNbYXm2JrEoaGU+pUC4zGyeacQ2VjgNNdTcZytw5fsw1+JZ3xeGcMGo/Zhfr3J4gk
X-Gm-Gg: AYBFou1xmaaqEjN4ED1+6ieT97QFO/r+w+JkCzeKLLYXBI656i+TMH7c+o/DWXY70/3
	vbBhW0SU+IZ36j5jKKIw1a2ZxGSDgMZxFTljUTfhOG1btVmH7dgmjEe4Tt7y/g7CKUMmRPiLDj6
	m//ynwVAfBzk8wSPsRJ+dLcGy6iTcGNqy8Jdw32l/2nzfrNdSpbvA5nf0rLiX24Km/p5cd84YiC
	m8h+oPR2NNEqtNkWRIPmQjFa+B/rCZN/rqnNuQ9ja++R/RYdR9duSsCdXRCp+fhcxTOcelZBBCh
	UxwyaKek+x/37IGIan+pBeX9chJJWuHklwqdadVfMpNnxcewuURh/dIwANSSKlKZSzZnLg2JwWv
	C2uU5vKBV02LT2xGmJPcLw0nAvLIXroN8JWgki8k02EIayjrsr9OXo3yLncyiKF4TT1wfFdKq50
	5yJphJdUc+vr8/9RghBSbpESyLK9gEHrdTXfGj0g8RHmp/OGBqwl5ILsBwSY9cA6oFAhfZeGwIp
	KukKYpFk9mEHz+h5OnEBUnruab9lxeZRIQHpxhZKGGJNsFeyhb0yFEQpn0rROb/pNWdn6S7EvQz
	6CZMudfku3jA/0ZCDa7Wysuz81WlOzGyfybEPE0yuxynW+XqTt/ABoRy+l6Xl4HHKmcOXFF9o0l
	N/RIVvGAkHLTbXwaTaGrPrJ62HwtYmns/7oGWAMRAqfuMl8efWAedgVnHNwBc
X-Received: by 2002:a17:90b:270d:b0:3a7:db88:3491 with SMTP id 98e67ed59e1d1-3ae898142dfmr14972954a91.33.1793868137061;
        Thu, 05 Nov 2026 00:42:17 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([118.217.70.161])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b32812a6sm2720088a91.11.2026.11.05.00.42.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Nov 2026 00:42:16 -0800 (PST)
From: Jongwon Lee <ai@linux.com>
To: Li Ming <ming.li@zohomail.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Richard Cheng <icheng@nvidia.com>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] cxl/edac: Read cached DRAM event records under the
 xarray lock
Date: Thu, 05 Nov 2026 17:42:12 +0900
Message-ID: <20261105084212.55292-lm1-ai@linux.com>
In-Reply-To: <417b4379-4f6a-4a31-b2a4-f6f84b13d362@zohomail.com>
References: <20261102123233.74598-1-ai@linux.com>
 <20261102123233.74598-2-ai@linux.com>
 <417b4379-4f6a-4a31-b2a4-f6f84b13d362@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Ming,

Thanks for the review.

On 11/5/26 15:42, Li Ming wrote:
>> +	xa_lock(&array_rec->rec_dram);
>> +	rec = __cxl_find_rec_dram(&array_rec->rec_dram, attrbs);
>> +	found = rec;
>> +	if (rec && out)
>> +		*out = *rec;
>> +	xa_unlock(&array_rec->rec_dram);
>> +
>> +	return found;
> I think this "found" is not needed, "return rec;" or "return (rec !=
> NULL);" is enough?

Right, the pointer is only compared after the unlock and never
dereferenced, so found is not needed. I'll return rec != NULL in v5 and
keep your and Richard's Reviewed-by.

Thanks,
Jongwon
