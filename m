Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B027A29E101
	for <linux-cxl@vger.kernel.org>; Thu,  6 Nov 2025 18:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762453551; cv=none; b=cS8PgO37DLpqvbWLB9xTzfl4Cyo34yPbIb7hNM6xeM40Awowro+jPWMBrbbr0b+/ITiZszIhon9A49cx9H/cTNA4q7I8F2yUQLEQ5geILVGSCnmB4JPo0lBFAAbJcfcjL2TV5EmTLENNvirhB0VxbFWvaDuuTNOhdgzJjNzy7NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762453551; c=relaxed/simple;
	bh=d49GAtLiWQ+gY1EKaUZBNDB5hNzMmi3WaSSV6czVI5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CziALbXaS183+5Q5vmWwGdYYWEiIdJpzGKqBfXT7pVpOS/zUwBcPryUPHTUJeUjUd3PMS3qKq1BiJUpCtwsqtjlLY02loL4qPBhFXomUfHkRb/hDeNGZLtgNjMJognNpOg6xYuDikkmZRG7VZW2mq2ocav+9TcRqdKbGo4Z8FaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=Ja7dRWoI; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="Ja7dRWoI"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8909f01bd00so131715285a.0
        for <linux-cxl@vger.kernel.org>; Thu, 06 Nov 2025 10:25:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762453548; x=1763058348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/aqZMvGx3cDulG83zxrmi7nWBQJY3Wx4JVbaMSnDC7s=;
        b=Ja7dRWoI0cK6X9SIhwXec1MqPFgbCYOT/WSU0ShGgU4Ig6hDIMtq7ZAK9CQVAddiuj
         i7nPPiZHyCSNkVGn7Ff8zI2UowNZXX3bbhacVno1AbZOKlrIZ42RaSerK0JeaHcL1aFN
         duWCQ2RJDnmqr/FmXJQ5CKnbzD6d9Xw7ILzJreSxTb2PZxR8kO7pMqwgo2Etx+s7Sm1W
         cd0SjODCaSg7IXiwDm874L8iTXe6nT0Fxi/reIpaw2xiYHSq7TfuuNXfSJ6eNpi5Lxq4
         80he0pDqb8R3ZGWBVQLhIkWR1Bsxr25fiRofSetQt4af90XsobXWLBPu7jaNrGDgASYU
         S6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762453548; x=1763058348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aqZMvGx3cDulG83zxrmi7nWBQJY3Wx4JVbaMSnDC7s=;
        b=s0CiGhhKSZ6ABvYda7KZZU94bYZFW4sUNBRLq9QAd5JmG1l4fs8C/sdisyfc403N79
         VYdHEvVsXhAS8R1nxWriXbvGDn67qQjpy33IZ26Rgh2UaZZkP7TzYb8XJmAs59n6EEm1
         J6jEY0At3DwbxUviZYSYWnj0I3EVKapFG2alMTqyGpbROjWoDyjjb5fheq56y4U+IUs7
         iY6AoQ0iBIFloLKSHQfHZyCgG2wrqKV3vyKYGiQXNY7eDknNHtdMoVThtb+HxwAOjskW
         VGA+fXkm9y5eo+tlhpQi81a0KbFMXH431GLSVPlFSRakRu825dZg2PcafcJm2DnYLw5J
         +qHA==
X-Forwarded-Encrypted: i=1; AJvYcCUaDsRe7yT2R2/3B4G8ePSWGIi3zhq5D3i57thodiKYlmzL2pjJq5uktMs6NYSJhrTT12mUQeu2Y3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqPccLl38FNdBb8Wujy5amY2d9PetulhndZ7JxMko5tLrzTe3i
	xxt3oet4Jn07LojclqDfdTjSzFhXx3b2V0ka9/jxDXDHNW+KLtkTidDA9zLz0CjGtvg=
X-Gm-Gg: ASbGnctqd6vKfVsP7kTPH+nmr6CG5TEJimSZ9M7FeysU8u9QBLYhy5sEomxOmgCJ3Rd
	7DApU6btX9ZsgD4BOKkknI64VS2iznOFLSHITyLVFe6mcAO6UYXb/CQud5wwdRGsSkB+2Y47ZNb
	7qxIMWQ7UzZyEhHZwLGz6ZwWjaPImiaByq3biXQOWLaCPxVnm+cIy3Xm9E4FXnjDKsri5hUXiwq
	NnJYuLxHtLwARbIfmzkC4XLzUVC0EYHpevSxyW5CIWEZ1Efn8Wlj03qv4s5Yqwyjd9ZkwKb8QoR
	M/g4p5eEwqZN21SvGQ7Pl+n5uB1QnozxKxWIjxxH8e3TqOS21AI5p5TaYnbA/hfcCgBUy21WmpS
	Ou9uXjpT1ga3SdZsEz1sBXcLX2EYO6rzuziqCchYf95nuT5u3HMfPM4T5d+l/9d4FfCbAuyg87I
	kLhZNWUdA+ahYbNCzZld4IpDS/LGnikulIdKLqX6JqCesRCM0QHxvgmPrxOXPDjloBJizyxA==
X-Google-Smtp-Source: AGHT+IGG88vgYrBYLoLwBIyOKJFlPURjqblZiHgoX+67U5H3JIp6YoUJbgYMMwMECaFVdN+v2cX85w==
X-Received: by 2002:a05:620a:1727:b0:89f:9693:2522 with SMTP id af79cd13be357-8b24533edd4mr86446585a.73.1762453548474;
        Thu, 06 Nov 2025 10:25:48 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b2357dbebasm244367385a.31.2025.11.06.10.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 10:25:47 -0800 (PST)
Date: Thu, 6 Nov 2025 13:25:45 -0500
From: Gregory Price <gourry@gourry.net>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Cc: Nathan Fontenot <nathan.fontenot@amd.com>,
	"Koralahalli Channabasappa, Smita" <Smita.KoralahalliChannabasappa@amd.com>,
	"Bowman, Terry" <terry.bowman@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
	Robert Richter <rrichter@amd.com>, Fan Ni <fan.ni@samsung.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	"Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] CXL/ACPI: Remove overlapping Soft Reserved regions before
 adding CFMW resources
Message-ID: <aQzoKWqfw4vfpFrW@gourry-fedora-PF4VCD3F>
References: <ad410c59-bf0f-47ae-aa65-c0d845e6f264@fujitsu.com>
 <2296acdf-de5d-4591-a165-d59f9f432dee@amd.com>
 <e545b630-1a89-40b1-996c-c843a9e8fad7@fujitsu.com>
 <aQznzIP6h5NibJM6@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQznzIP6h5NibJM6@gourry-fedora-PF4VCD3F>

On Thu, Nov 06, 2025 at 01:24:12PM -0500, Gregory Price wrote:
> On Fri, Jul 11, 2025 at 05:34:27AM +0000, Zhijian Li (Fujitsu) wrote:
> 
> with CXL_REGION=n you cannot create the dax region.
> 
> region0 --creates-> dax_region0 --creates-> dax0
> 
> all you've done here by setting CXL_REGION=N is break the probe chain
> but otherwise successfully attributed the memory to the CXL driver.
> 

apologies, disregard, this old email somehow managed to make its way to
the top of my queue.  This code has changed significantly since july
lol.  Sorry for the noise.

~Gregory
