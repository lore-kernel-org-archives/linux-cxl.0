Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A921B30BB94
	for <linux-cxl@vger.kernel.org>; Wed, 24 Sep 2025 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733793; cv=none; b=KaTZr9zWw/qROwuJXVd5mWAPsvvt+IEe7wMMQtomvIqkC7XuYnEMxYa+0g+VlJRSaMYYn4UJfMrFv7e3mJxNMyf4N/VEFjJZUU4x0igLoW0+TBrEdb2UdBWha103YfkiDTxTlS4Zft8YoWu+S+dQZjCYhnRObJ/DEM+rCxxfFeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733793; c=relaxed/simple;
	bh=oyrAbyutMr1gRbHhzc8Y83fiuBCvcnjsrICPwfRA6O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ep9xiX2VPkqNPsUx6MqgogZfUE7ldy7KdQTCeJiwnjh81LOmRFlvRKaXPmd7BKTZxXXhZJYLvq1Kca6rjMWk5TXuWmMHcsSW1ynr1Mxlbfe4AoN8AxQnRG5oqSZlQxUhT5Nfwj0nghksTQrqLs2bcrUpSmrQuKHUBlgvINaVhoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=LStY4TSm; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="LStY4TSm"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-42486ed0706so226125ab.0
        for <linux-cxl@vger.kernel.org>; Wed, 24 Sep 2025 10:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1758733790; x=1759338590; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=26T7VUsEbTXS7ZWOF9xPs/3xJgAyNlS5cwtU+OCVVXU=;
        b=LStY4TSms9burCgYXfLlY75ooAeeDo1KfvLneAsb3sIiFB4Us9cMkA7l/kw7W6VYzQ
         DpzZYAb2on5Oa0ULqAOxDm/BGOLQh27nwsX7UycHjQELOCW60Xcf3cwEtMtUv86+Bwr6
         sHziSvXiZcfs2WIzG92cKVUZsjifqZhY3VhLSqELKY5Ep5zw4jZq0CF+NL1RJOIPQ6C3
         6Air6emJULzdBSzMM8nl3x164HvfGKVnAXTjvX5tsgJR8xuZEKilW2wxyWmnHVgPgXes
         cXPDVLQyXRBmS30yM8NL8RvbE/bV8fNkrOZkaeSR871Z56uaGyJx7VG2f2zA7YYrZst2
         lKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758733790; x=1759338590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=26T7VUsEbTXS7ZWOF9xPs/3xJgAyNlS5cwtU+OCVVXU=;
        b=FwrPQqarH3ZkHsknyOl5pS674syUCNAx2ON+VwpdJBKZFyBAIEW7AKJYvXNOefGn+Q
         X9QyxTw9nOnlTe9VYWBfWNd6tnTqWz72qjEKAOKe/NcXenQLbd+8huhZVGmMh9+ECSTO
         QVOMcC2T7k0VhhOH4+iT2dmqvcrA2LsMUnhIMqMPEZUEXvmJHeqv9tNU3Doj54puYiQ/
         PSn4/ClO3bTdKkUJkv3n/vED1FcOwKnUg2Z3m76d84L4iwz/doWrBlWvqEIObuKr1boB
         AqVFkq17T4ZO0wAoLY+vIt5OiBLxlbINTSGZJHNeVoqSBMnKSyh6aZewSi78fhWRW8t5
         SHYA==
X-Forwarded-Encrypted: i=1; AJvYcCVMpA7IcJUwZtMOWcnIhrhrUcVgMSUl/lfQAKN1hIdnIvkxjsIw8tB6JfJRYMd5CZcHXJ3t43TbExE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ODNWx56etLLp8abmQofQdxe/urA/mCLOP/UyS30dXk0gaW0A
	AnoH5JLxnhF/wehNHWsf3iU0diHQNdUiX2h+J5rtwKUmIa1+2Uw1P7xX5FW2dBUJhJQ=
X-Gm-Gg: ASbGncuZaT4KhaHonWQpy07I+e2Kn1lj+qHCXYmTvR+Y68hcNajXJuiA0Vqqw/+HMh7
	QWHgmJIoFMr07XpHWLxb3V8MP43K92gOJcvEgvKg6qirTDFRVzkknaaRIE1A7VYPWHb031DMHLF
	X+ddrPdldOJlWi5QAntbZAeJ2zmZpAq7UIx/S9UUwc28HIbdvK4zEAIVDm8Jkkpchd7lBIympfm
	ac6o1E2ar+EM5LhnwS2SZg17bsfB+ZajADE6rf/7Tsf9OzoKdwrSK4Et5iy1oQVVBFsv7g5+3AC
	TjSUnqcjCdp9lBesw1x2pkZiFYlWOriZ+mPtVNMUXgzxuZgNnpHh4B+1a9PHzmbuSDtBk+wIKwg
	9y9afzq/50egqMg8JnVGGhtMb5sKL6x6e88BpgxG+i2qg6z4fqgXQQ/NrTJ68uK+bL4ar0gcXX8
	o=
X-Google-Smtp-Source: AGHT+IGNmvEkhMyWszEWjjDEsj7P599Wf7BkeW1PhMFYduB6UXhkk03TlxUuapEk8nPHgCVWDcW7MA==
X-Received: by 2002:a05:6e02:2193:b0:424:2d4:585e with SMTP id e9e14a558f8ab-425955cff8bmr5442645ab.1.1758733789523;
        Wed, 24 Sep 2025 10:09:49 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (50-32-2-77.vng01.dlls.pa.frontiernet.net. [50.32.2.77])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-556f892fe73sm4718446173.58.2025.09.24.10.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 10:09:49 -0700 (PDT)
Date: Wed, 24 Sep 2025 13:09:46 -0400
From: Gregory Price <gourry@gourry.net>
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 11/11] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Message-ID: <aNQl2ogOPKid7yyp@gourry-fedora-PF4VCD3F>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-12-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912144514.526441-12-rrichter@amd.com>

On Fri, Sep 12, 2025 at 04:45:13PM +0200, Robert Richter wrote:
> +static void cxl_prm_init(struct cxl_port *port)
> +{
> +	u64 spa;
> +	struct prm_cxl_dpa_spa_data data = { .out = &spa, };
> +	int rc;
> +
> +	if (!check_prm_address_translation(port))
> +		return;
> +
> +	/* Check kernel (-EOPNOTSUPP) and firmware support (-ENODEV) */
> +	rc = acpi_call_prm_handler(prm_cxl_dpa_spa_guid, &data);
> +	if (rc == -EOPNOTSUPP || rc == -ENODEV)
> +		return;
> +
> +	port->to_hpa = cxl_prm_to_hpa;
> +
> +	dev_dbg(port->host_bridge, "PRM address translation enabled for %s.\n",
> +		dev_name(&port->dev));
> +}

Is it possible that the PRMT function is present but uninitialize?
For example if expanders are not in a normalized address mode.

This code would likely still add the to_hpa() function reference even
if the underlying PRMT function hasn't been set up for translation.

~Gregory
