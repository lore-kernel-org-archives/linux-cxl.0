Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C526E20D4E1
	for <linux-cxl@vger.kernel.org>; Thu, 12 Jun 2025 07:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749712741; cv=none; b=ivYs0mvdKsw8oLPBeosT5ScLuTS8r1A5mfqpI3zG2BKPaoCCqXQptwWUgwmdeTIkGAtJIzKDhNTlDW0UFi91T4B8vto/xzSxWAbS7hyJISxLL+tqEr+1wV9WaKju5RNKluBYsKSDZpg4GpkMFPFCAXmbub6U0kaUsSTzNiZvx5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749712741; c=relaxed/simple;
	bh=E4o4+NkVdMsSwo6NSZE73XR/7IFF09J3OvpKyCjdrdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHoYrcbiU/qoUBGad8LkjYOZIiF3nP/IKNMX/hHw1Qt0IC9RpBLC1lqHluo1de1p+KqH885BVO2/rXaKynHVyy/OBaqdO5HHRTi8/Vz/SGocYOYjW8ON4HakVzszO9ObCixBZknsIF3XBMrGrgkJD5y5miU1LO4cMkR6LFdfIaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=id2k5UbN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="id2k5UbN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749712738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/FORcX77Z/dfz/4nX8LN31ZOLAOS6nLNcf+1RkLQzco=;
	b=id2k5UbNMNkYF9BjZ9+B4pQ1jLeJ9tOOeI2yv3RNiTO71FojCG1ehkUMiggjlJSQogoMyG
	2jXvU+h0m2EGPxTaDlCoK3aZYxFnH7e4nNYD4JONkLez2t656BQKHBgpGshuAAIVS7Eh0J
	TSPg7VJuIXC6sgIOLVxjvENkfyT4hBc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-H7NdxqplNmatxt8dN1Zzxg-1; Thu, 12 Jun 2025 03:18:57 -0400
X-MC-Unique: H7NdxqplNmatxt8dN1Zzxg-1
X-Mimecast-MFC-AGG-ID: H7NdxqplNmatxt8dN1Zzxg_1749712736
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4eeed54c2so378720f8f.3
        for <linux-cxl@vger.kernel.org>; Thu, 12 Jun 2025 00:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749712736; x=1750317536;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/FORcX77Z/dfz/4nX8LN31ZOLAOS6nLNcf+1RkLQzco=;
        b=mHV6sV8ZK+T5jVmPz+PQiAsUcYGY0L2Ej5paABwlEo2p/6KCGI/voGnlk8Rzg0Dq/1
         2TuApHg9/3UWRLKzzpzWsLBthwb+7fGwx2b/lpj/j6L6gkL4vRHo9Tk6GUKNeF9ibDE2
         e/IJj7y5u0rI0pOm6O0I1jHLe38Z4o80rDJHLNaPYCzme807gNDysjnr2eTMuDNiT8vm
         gmtB3MgsMiO+99hDQjrnhArbme5c2o4I2M0hxfyn4MgRxmfCphqy5Bmvtw2mlgTpQTRs
         C753v2jY6ExRbcNwyulvi8t5CE9XE45gO8P6mQRIb0IrUwnd8PY9SSdvvUruHMI9LJxj
         dhog==
X-Forwarded-Encrypted: i=1; AJvYcCWlB3OGUxV4Xd4JMtejvRcuHgmXR07Gc28CoipNjiQV3Fz+S9X9u9dHUYNwxk0HvcvlhGo1O2bAZjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yysy7vtwliypCLkejMIDZGwFTPf6W7prwAMuRwabr7VtDVEDAiV
	TNNeYQxUpE/KTj1BloXBSdLl+YeZBDWrjVArdly1vG08jKhyc2wzSZ6ShSH7PTXGieMVO3Az+OW
	3J3mIWcDjB/3uh6jZUR+ZUlFJguTLggwnwI5BCD1nZooVIK/PtZWwZKq1ieNnvw==
X-Gm-Gg: ASbGncvKq0eNRhL0S+eDCasH8aDl//DjCX1t12wAFAhYD+nZx5HHgwL/vxDInUOjjb+
	XammBBa276B9fZaU3UmTg3wZvIDph3KqLJIw8cEFhlZHCvoUT5GjrmoWpr7ruLLlknD+0bU94ip
	Y9QdA082pkjvLQauhoGNChAPdRyyChidwHMPl8w2yS+dCdqXiqzwgllJgOJbS9RO7sib7KSczBw
	BnGLXuhfw1A+1QlgOgBc5ylvAn+yeIHkmP3hn73dD577nDUig2iRPo5R9c77Z5gB/2B9Oe2pFE4
	oLQn1DbC8fGqD42lkqG8VhLjSQmCIUgs8h5xE7FFmwm28KxNmgAZnLYCV1KsIp8TxL6PX6tLt6E
	B5AFyuYKePCHnSEbPDonpQhmk/Nl7pKnCdfvGWeKDH/v5XK9wPA==
X-Received: by 2002:a05:6000:1acc:b0:3a5:1c3c:8d8d with SMTP id ffacd0b85a97d-3a56080ad40mr1700208f8f.55.1749712735781;
        Thu, 12 Jun 2025 00:18:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnuzBb21Wl7Xf5s9zBtEXduPrHUbE8WIdQsQ0ZDweoN2mKdK4HhlsxKte8GKHdxrB+9zyk/A==
X-Received: by 2002:a05:6000:1acc:b0:3a5:1c3c:8d8d with SMTP id ffacd0b85a97d-3a56080ad40mr1700180f8f.55.1749712735299;
        Thu, 12 Jun 2025 00:18:55 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2c:1e00:1e1e:7a32:e798:6457? (p200300d82f2c1e001e1e7a32e7986457.dip0.t-ipconnect.de. [2003:d8:2f2c:1e00:1e1e:7a32:e798:6457])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5619ab781sm1100303f8f.43.2025.06.12.00.18.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 00:18:54 -0700 (PDT)
Message-ID: <990ce9cf-0e48-432c-a29f-0bd1704eede4@redhat.com>
Date: Thu, 12 Jun 2025 09:18:53 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] mm/huge_memory: vmf_insert_folio_*() and
 vmf_insert_pfn_pud() fixes
To: Dan Williams <dan.j.williams@intel.com>,
 Alistair Popple <apopple@nvidia.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Oscar Salvador <osalvador@suse.de>,
 marc.herbert@linux.intel.com
References: <20250611120654.545963-1-david@redhat.com>
 <lpfprux2x34qjgpuk6ufvuq4akzolt3gwn5t4hmfakxcqakgqy@ciiwnsoqsl6j>
 <684a5594eb21d_2491100de@dwillia2-xfh.jf.intel.com.notmuch>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <684a5594eb21d_2491100de@dwillia2-xfh.jf.intel.com.notmuch>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2E7eP9CAWXCATKB6i7f27hEmECN4w3NBkYLqOzrVQEU_1749712736
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.06.25 06:20, Dan Williams wrote:
> Alistair Popple wrote:
>> On Wed, Jun 11, 2025 at 02:06:51PM +0200, David Hildenbrand wrote:
>>> This is v2 of
>>> 	"[PATCH v1 0/2] mm/huge_memory: don't mark refcounted pages special
>>> 	 in vmf_insert_folio_*()"
>>> Now with one additional fix, based on mm/mm-unstable.
>>>
>>> While working on improving vm_normal_page() and friends, I stumbled
>>> over this issues: refcounted "normal" pages must not be marked
>>> using pmd_special() / pud_special().
>>>
>>> Fortunately, so far there doesn't seem to be serious damage.
>>>
>>> I spent too much time trying to get the ndctl tests mentioned by Dan
>>> running (.config tweaks, memmap= setup, ... ), without getting them to
>>> pass even without these patches. Some SKIP, some FAIL, some sometimes
>>> suddenly SKIP on first invocation, ... instructions unclear or the tests
>>> are shaky. This is how far I got:
>>
>> FWIW I had a similar experience, although I eventually got the FAIL cases below
>> to pass. I forget exactly what I needed to tweak for that though :-/
> 
> Add Marc who has been working to clean the documentation up to solve the
> reproducibility problem with standing up new environments to run these
> tests.

I was about to send some doc improvements myself, but I didn't manage to 
get the tests running in the first place ... even after trying hard :)

I think there is also one issue with a test that requires you to 
actually install ndctl ... and some tests seem to temporarily fail with 
weird issues regarding "file size problems with /proc/kallsyms", 
whereby, ... there are no such file size problems :)

All a bit shaky. The "memmap=" stuff is not documented anywhere for the 
tests, which is required for some tests I think. Maybe it should be 
added, not sure how big of an area we actually need, though.

> 
> http://lore.kernel.org/20250521002640.1700283-1-marc.herbert@linux.intel.com
> 

I think I have CONFIG_XFS_FS=m (instead of y) and CONFIG_DAX=y (instead 
of =m), and CONFIG_NFIT_SECURITY_DEBUG not set (instead of =y).

Let me try with these settings adjusted.

> There is also the run_qemu project that automates build an environment for this.
> 
> https://github.com/pmem/run_qemu
> 
> ...but comes with its own set of quirks.
> 
> I have the following fixups applied to my environment to get his going on
> Fedora 42 with v6.16-rc1:
> 
> diff --git a/README.md b/README.md
> index 37314db7a155..8e06908d5921 100644
> --- a/README.md
> +++ b/README.md
> @@ -84,6 +84,11 @@ loaded.  To build and install nfit_test.ko:
>      CONFIG_TRANSPARENT_HUGEPAGE=y
>      ```
>   
> +1. Install the following packages, (Fedora instructions):
> +   ```
> +   dnf install e2fsprogs xfsprogs parted jq trace-cmd hostname fio fio-engine-dev-dax
> +   ```
> +
>   1. Build and install the unit test enabled libnvdimm modules in the
>      following order.  The unit test modules need to be in place prior to
>      the `depmod` that runs during the final `modules_install`
> diff --git a/test/dax.sh b/test/dax.sh
> index 3ffbc8079eba..98faaf0eb9b2 100755
> --- a/test/dax.sh
> +++ b/test/dax.sh
> @@ -37,13 +37,14 @@ run_test() {
>   	rc=1
>   	while read -r p; do
>   		[[ $p ]] || continue
> +		[[ $p == cpus=* ]] && continue
>   		if [ "$count" -lt 10 ]; then
>   			if [ "$p" != "0x100" ] && [ "$p" != "NOPAGE" ]; then
>   				cleanup "$1"
>   			fi
>   		fi
>   		count=$((count + 1))
> -	done < <(trace-cmd report | awk '{ print $21 }')
> +	done < <(trace-cmd report | awk '{ print $NF }')
>   
>   	if [ $count -lt 10 ]; then
>   		cleanup "$1"
> 
> In the meantime, do not hesitate to ask me to run these tests.

Yes, thanks, and thanks for running these tests.

> 
> FWIW with these patches on top of -rc1 I get:
> 
> ---
> 
> [root@host ndctl]# meson test -C build --suite ndctl:dax
> ninja: Entering directory `/root/git/ndctl/build'
> [168/168] Linking target ndctl/ndctl
>   1/13 ndctl:dax / daxdev-errors.sh          OK              12.60s
>   2/13 ndctl:dax / multi-dax.sh              OK               2.47s
>   3/13 ndctl:dax / sub-section.sh            OK               6.30s
>   4/13 ndctl:dax / dax-dev                   OK               0.04s
>   5/13 ndctl:dax / dax-ext4.sh               OK               3.04s
>   6/13 ndctl:dax / dax-xfs.sh                OK               3.10s
>   7/13 ndctl:dax / device-dax                OK               9.66s
>   8/13 ndctl:dax / revoke-devmem             OK               0.22s
>   9/13 ndctl:dax / device-dax-fio.sh         OK              32.32s
> 10/13 ndctl:dax / daxctl-devices.sh         OK               2.31s
> 11/13 ndctl:dax / daxctl-create.sh          SKIP             0.25s   exit status 77
> 12/13 ndctl:dax / dm.sh                     OK               1.00s
> 13/13 ndctl:dax / mmap.sh                   OK              62.27s
> 
> Ok:                12
> Fail:              0
> Skipped:           1
> 
> Full log written to /root/git/ndctl/build/meson-logs/testlog.txt
> 
> ---
> 
> Note that the daxctl-create.sh skip is a known unrelated v6.16-rc1 regression
> fixed with this set:
> 
> http://lore.kernel.org/20250607033228.1475625-1-dan.j.williams@intel.com
> 
> You can add:
> 
> Tested-by: Dan Williams <dan.j.williams@intel.com>
> 

Thanks!

-- 
Cheers,

David / dhildenb

