Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775B0198A32
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 07:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738913707; cv=none; b=leXpnjZW/ijXeFSwJrVJuVRAcCBFfPzubQgEgCgL0Xb6HMa1s3IubdD6K5c2pG086nHAYhnpM+mJ0X3y7rIY7lFAz4dbH6LY3jrcphQdm1+T7xJvmCu5PA6w9gjoS6DTwIRaOj+HJCsR0knioq08Up7eXOZvBF6gFyMXswmrBuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738913707; c=relaxed/simple;
	bh=SoKfZsMWM++7qSwG9M+ObHWZT0yu/xHXf31AK8qwgbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJ8Q9szpyWeiTB5hSgfbDy4UdSY6naneUtN++KpBr5qxx2RtCy4HFP3/2MVko0kiF5EbZV2sJo8HSvMAZtWi/HjP+S5iF9WtvoG7RdutdnJQHEyOmnHFl6dkZP0oYazUYW934o14SLBRUT4K4QAYuha10NyrgzYU/DDyI0iq9Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QCfHLlsN; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QCfHLlsN"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b6f53c12adso143117885a.1
        for <linux-cxl@vger.kernel.org>; Thu, 06 Feb 2025 23:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1738913705; x=1739518505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S985nb84gx3fKGG3CziKlQ8YyE/d/ai620mo1qQAcd4=;
        b=QCfHLlsNS44BCvA/g6cLK2H5qdHS+yYeSdTeIZi/Y9TILkmnJWw2AMDSt5bZ+Ur38j
         l5D7UK4DLD7dAUK0tiDHckeGtHwtMA3bm/EYGqI5nN1Bmre7BcsdydApo8snh67D9A1u
         XVI/b0r869E0B5qzXdczopOsNMZ1a/yhhtwJUy1nOzpSuLJhulwtpW7kJ0y8ocFi30PX
         F/J92ZnOsjIIfuSKa5kHRaWen+bxPvwMH7oeacQc5i3M+lPCK7d2hjUkIg8dZsygAZZv
         8n3cOzcLSE3jZp6lrB5IXvC9KXlk3krgeS0aVmiqiZuziTr9GrzEN95J+ORZYWTh8Ay8
         lntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738913705; x=1739518505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S985nb84gx3fKGG3CziKlQ8YyE/d/ai620mo1qQAcd4=;
        b=KiPxe1Cov6XMDRQNUoewXO52456aW3mntAzOpRTjPtjgvxIHR84FSGEPcs37VgRZUP
         d9X8UPi2hC0v8DAptCOmO+co/VcsfPcAMHtTgX0IHJPT43ABu1d9c6K6uQ2kI1zARjmc
         N8JHnlcN+hKC9cy8VriuRo4xYu2+00/IycBEPUJyRO9QJQDu2MQH/iyMqXMn9Zf5sxNW
         k7yP0pfkIUnkqp8m8+93nehx1BBnOZP+TdVu+CxYQ9Mo7U1d1sVOwv0MYDXwrMPk2vJR
         c6F8AcZviWi7ARSp4sfAUxHL2F83uYna7kZYbpp/TJgcfZStXqFjm70ApK0CjZy7uKAC
         kodA==
X-Gm-Message-State: AOJu0YwEV5aogBvKcIzP3G56GPyQI39NG7qMwjTUf9Gg68h5BFxSiUJt
	OMMNip4oz95hNnaLAOqsPURDTIGVPkQnZ3hgmrUruk+c+vHwO5qc9/p8fIojkEY=
X-Gm-Gg: ASbGncu4tj2oPsOvlhifOGXFAm1EHOQQHqklgI7Wipak8Y4GUCdKD27TkYHsEfjbbNR
	odbEoryXkT0jBtjxoql3jP7r9+AXDo9tE26fWhwKYUrTLp4hltv+Sey5If5efc1XLhXsg0IqwVA
	Qo1tquAGCARjaeqD6jYpRwC07tRA7gx+EsD214MLTVOcGgIqN7XraMCRJNd2tTGgAKSXtpablEW
	wzvVxMNlOS4/K+Vc77ZIEfW/9u3EusDCYLeftoV+uKgOZojFUx8jOF3E4OF/iYe6qHFDKDknWYM
	ufWN3BsH3YPmDMqj3qOShvFabRLCsfabzdPWtdVJGt+dSw2aPXAAEVs+wDN4hSWEAMqjyT9lwQ=
	=
X-Google-Smtp-Source: AGHT+IHR2VWtK5UoYrz7dJOeFMRcEgTDUb47l42Cs0Jrr9jUdPON+1TgDBAhn04WkWpQ6sv6zHS7uw==
X-Received: by 2002:a05:620a:4b45:b0:7b6:f03e:6c0e with SMTP id af79cd13be357-7c047bc6debmr252927585a.31.1738913705408;
        Thu, 06 Feb 2025 23:35:05 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c041dec129sm157964185a.18.2025.02.06.23.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 23:35:05 -0800 (PST)
Date: Fri, 7 Feb 2025 02:35:03 -0500
From: Gregory Price <gourry@gourry.net>
To: Terry Bowman <terry.bowman@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, nifan.cxl@gmail.com, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
	ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
	rrichter@amd.com, nathan.fontenot@amd.com,
	Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
	ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com,
	alucerop@amd.com
Subject: Re: [PATCH v5 09/16] cxl/pci: Map CXL PCIe Upstream Switch Port RAS
 registers
Message-ID: <Z6W3p1h9ghcBF_R6@gourry-fedora-PF4VCD3F>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
 <20250107143852.3692571-10-terry.bowman@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107143852.3692571-10-terry.bowman@amd.com>

On Tue, Jan 07, 2025 at 08:38:45AM -0600, Terry Bowman wrote:
> Add logic to map CXL PCIe Upstream Switch Port (USP) RAS registers.
> 
> Introduce 'struct cxl_regs' member into 'struct cxl_port' to cache a
> pointer to the CXL Upstream Port's mapped RAS registers.
> 
> Also, introduce cxl_uport_init_ras_reporting() to perform the USP RAS
> register mapping. This is similar to the existing
> cxl_dport_init_ras_reporting() but for USP devices.
> 
> The USP may have multiple downstream endpoints. Before mapping AER
> registers check if the registers are already mapped.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Gregory Price <gourry@gourry.net>

