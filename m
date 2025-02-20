Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D42B3214
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 00:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740012980; cv=pass; b=JwzW7TaB0z162V4ea4FG0R40q2yS9Hi6VpKuX+SaCNVJ6qVc27vXmiDFwSQrcKG1xpaG0WQVKr3s+qzBP2L59zNRQNCP7ZVkUjkrt8yB9S+6BrDvVfGTN4CordIpo2wZU0Dpwhu4I3zqS8w6nm+o2QCgofKtge8bpyhc9muAUig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740012980; c=relaxed/simple;
	bh=pu9VcmRyI58OO5O7epC2YjPd6EDoTNNqOKDUQpKBkik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TpKMihJKfxpENSxDJyJq5Sw72DXNqVF5LT2EUYnPwAb+4goHGpdyCUk0QwaoTBX+nDsuTwj4sPEukPDR4MAlg4rSyaRgsQ+QPKZNS1lKf040f9829gAOQ6IQfZWakmSPvK6nRmuYPK3rhG+mxoM95UuyP6BEUTSS2OpPS/AOe1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=AMc6Z8QF; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="AMc6Z8QF"
ARC-Seal: i=1; a=rsa-sha256; t=1740012964; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dqSlirK/7wmWzK7sHPdtR8XedQRCON+e4/OB6QsLXMJJWlJVPNs37QTFSPiMon9IUFzwgvJRNAToY2zVto5DHjAI9do9I4n0d9CmEhlxG87z3n8nHtm+dbvIPEVqjz1BGNMmjULmiZxKuH9dnrVZXiXpplNAvewOuDC3MorSONw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740012964; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pu9VcmRyI58OO5O7epC2YjPd6EDoTNNqOKDUQpKBkik=; 
	b=aWVYjzEY10zvuWD4TvLNaSIx/0ryvR8fBpMs/v2p+U8b2hp8FsPLViWEn82PL7u5i4JhuqIzW9LhyU+xOCoaLb3AvPVik1AaeqQmYbcDkBTb8cWOcujUHome+GhahjRr3y9NvrGQoKzXlPD+WeDyxqpVS3DGPT6uq6/k8ZoLhrw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740012964;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To;
	bh=pu9VcmRyI58OO5O7epC2YjPd6EDoTNNqOKDUQpKBkik=;
	b=AMc6Z8QFgAbVAqmVBenFPRB0hhYpnpxLbaEbRN8qYFMu85IBqem0aJh0SCHwcLsx
	FWLhvrzAR0dx8S8/A70jOnDwFhRC0ySho3fXAqR7M0wTb0uArPMOihuMzL6/TEJIc+U
	qPtRSXDL+rZ+8z6YSlQge6rlYHLrisN+SVTx9JX4=
Received: by mx.zohomail.com with SMTPS id 1740012962807701.7703290380881;
	Wed, 19 Feb 2025 16:56:02 -0800 (PST)
Message-ID: <c8631d86-e5dc-461e-91ab-69bc5daa40d3@zohomail.com>
Date: Thu, 20 Feb 2025 08:56:01 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] cxl/pmem: Rename cxl_dirty_shutdown_state()
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, seven.yi.lee@gmail.com,
 a.manzanares@samsung.com, fan.ni@samsung.com, anisa.su@samsung.com,
 linux-cxl@vger.kernel.org, dave.jiang@intel.com, dan.j.williams@intel.com
References: <20250219062832.237881-1-dave@stgolabs.net>
 <20250219062832.237881-3-dave@stgolabs.net>
From: Li Ming <ming.li@zohomail.com>
In-Reply-To: <20250219062832.237881-3-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Feedback-ID: rr08011227e2d719ad874e35e9bfa8beab00002f6b3cd7fc5c51da488d169712fd9fa011dafb33dfe493cb89:zu08011227b13cf9d7fae7a52fe64bb5d60000cb677bbabbc87309072c4eabc92bc06e112a7da30a4c713621:rf0801122d7aff1c9ae0c92d2a7e2498bd0000e906044dbec02f2d09a1b151ec69f0b281655f23b907fc018c1cfc47080de8:ZohoMail
X-ZohoMailClient: External

On 2/19/2025 2:28 PM, Davidlohr Bueso wrote:
> ... to a better suited 'cxl_arm_dirty_shutdown()'.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Li Ming <ming.li@zohomail.com>

