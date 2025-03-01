Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F421DFFC;
	Sat,  1 Mar 2025 03:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740798024; cv=pass; b=V5F3LVY1fDowRDqB1aD+WH1LaOmuUb/cScQeY+FNcuaa39gohdUDwNJyzR1tkYMVN3FZ+O2rZdF3v9mPMAFR0Z+2/yaKrO8tjgTynfvPEsPP93ydT5aPEboiRdMJ8Suxj0RBWFTlSwWvh14Iz7C84zkRlaYNWzWUhPmHvJNT6f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740798024; c=relaxed/simple;
	bh=s6wHvNcoVBg3+4pdzsn5oRlUN88czm5v5BrRXH0Ufrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XD7NTEGyEhrgk6j+sMzK8pCtMqBFKCa/ZQ3ki1Vb7fNsxTpGVjTdMD4c0xs4HaIpfRks/pLzLtUKhYjNoLg2gbZpUW3oRrE/CMJWXmuuN70HxBgUiWvDGZEbLNqcd64+uge0FMzHSJ6riFehoa7aDSL9CIszYS3IoS3PwWlDmyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=VV6Tye0s; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="VV6Tye0s"
ARC-Seal: i=1; a=rsa-sha256; t=1740798005; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=l3mJJ0oizngCiWR5yk6Mi2hwhDS67xmdGw3OK5dwJ+62wrsoUM3/x5e8h3q2cdQGo/H249vrhSde3XdQOhbw+7NFxusJ7Cii84HvakMvbwQK1EcHeW5q2e1D3fP4hMhBVzYZG/K3f4MmFsPTAaQ7eW3LO6TuG4ZUHHT95UkEGKI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740798005; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cZF6XzsvCR1XR8oqjw3BHQdejOWrm4ZSbzyxGwvVlH8=; 
	b=kgkwGgQ2ZHgzj+lJP23vGkZX7h2ZqMKuz/h3laAxR7U+mEGZ3I16udU6x6x5vjiwyxV7a8lYlTukXf7ClAKn4G5TT/iO9yqr+EyoAmEwUnTA12J47h8CV23Q6H+73tLzC3TDxd6g8MOJ0ixb5QBm/VXXJfHmUgPIe1cSkl7Klrg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740798005;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=cZF6XzsvCR1XR8oqjw3BHQdejOWrm4ZSbzyxGwvVlH8=;
	b=VV6Tye0swami4jGO/829GSCGko9XYWdG1JsqhP8vXw9n+yf9G5mNSkRy65Ep6B9V
	6foS5BtxBpcv02TGOkj4jPG55CrMd1KH4/Krtzs81vuSgrnVnUO0rd256v3HlJcCXU/
	Yw8HXweZo7x8zoVYFXF/xkeGVll/4klZMfSwryTo=
Received: by mx.zohomail.com with SMTPS id 1740798002751500.5632278646382;
	Fri, 28 Feb 2025 19:00:02 -0800 (PST)
Message-ID: <d11bd4d3-2e8c-4e2f-9b2f-6bbe424058d3@zohomail.com>
Date: Sat, 1 Mar 2025 11:00:01 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] cxl/hdm: Verify HDM decoder capabilities after
 parsing
To: Dan Williams <dan.j.williams@intel.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250227103251.390147-1-ming.li@zohomail.com>
 <Z8DdafbX6_tbM4DW@aschofie-mobl2.lan>
 <4c97ec3a-3435-4e79-8265-6a82ae930c3e@zohomail.com>
 <Z8IBuE714QNscgfJ@aschofie-mobl2.lan>
 <67c24a88bb358_1a7729481@dwillia2-xfh.jf.intel.com.notmuch>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <67c24a88bb358_1a7729481@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227d46a6e82f5a9e6e01583c3d70000e9db9a12217fdf05a65132789f6dea16da2d72dc7f14fa9d30:zu0801122783ef9dae2e8277d6e44d144500004c79635f8fc426a1a4d391c2c55b4f5649275bd484c4301695:rf0801122d9b87e4d4b1754ae2d76601e80000502543d7623ddec995aabde8ac9bb1ea608cebcb8670dbe0e2abecfc5a5b79:ZohoMail
X-ZohoMailClient: External

On 3/1/2025 7:45 AM, Dan Williams wrote:
> Alison Schofield wrote:
>> On Fri, Feb 28, 2025 at 10:47:12AM +0800, Li Ming wrote:
>>> On 2/28/2025 5:47 AM, Alison Schofield wrote:
>>>> On Thu, Feb 27, 2025 at 06:32:51PM +0800, Li Ming wrote:
>>>>> devm_cxl_setup_hdm() only checks if decoder_count is 0 after parsing HDM
>>>>> decoder capability, But according to the implementation of
>>>>> cxl_hdm_decoder_count(), cxlhdm->decoder_count will never be 0.
>>>> How does a check against the spec maximums benefit this driver? Is there
>>>> a bad path we avoid by checking and quitting at this point.
>>>
>>> My understanding is that no a bad path on driver side if the decoder_count is greater than the maximum number spec defines.
>>>
>>> Driver just allocates cxl decoders on the port based on the value of decoder_count. But I am not sure if hardware will have other potential problems when it didn't follow the spec.
>> I had the general thought that the driver is not responsible for
>> compliance checking the device, unless it affects function. Excessive
>> decoder_count's sound like they cause needless allocations, so let's
>> stop doing that - as best we can. 
> Only if we see a device in the wild that causes an actual problem.
> Otherwise this is a losing theoretical game of adding checks for things
> that will likely never be violated. The way to address devices that
> violate spec expectations *and* cause end user visible pain is to add
> quirks. The allocation of a few extra decoders is does not amount to
> that standard.
>
> Lets not add checks for benign issues "just because", or "just in case".
> If the check is cheap and we need to do it for the driver's own internal
> sanity, fine, but if it's just being strict for strictness sake, please
> no.

Got it, thanks for explanation.


Ming

