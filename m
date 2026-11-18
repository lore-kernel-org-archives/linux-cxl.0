Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795019195;
	b=lgwnazU5zBAn4xDu9LHfqgXPKo7EPnBBLp4wJGPqfWlhyjoEl1Cbbn8vSL5RnADqkxwx
	 /JsGwqborBb5WPq5872otioaRIGuFG7YdNRVzBZMDC0u+4kAShmxsjefcpk5FrdC929x7
	 DaqxNYZiXnSrufq2C3AkJPaba66nVwSzYOywo6Ju8orWu0lvMzSuS3nzFzJKS/JAvUnhf
	 I3ieWZ/RXSVIMN6NatenhiPfv4OrcwTGYu3CvCZN9aSPf8b/dPW1a0Wi8UHywboZsJ+IE
	 gg0iwplepL7My+VVbOjXe3rJ0TclAYNc8Xik15J/JDZwhJnIGk+wzb/cCQqpJRW09nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019195;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:From:Content-Language:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=rpNU+lC1QwS1gtlyPIaH60leRy51GKw1Y2cF3YAlqfk=;
	b=S/3hH9XZ1s+6cwr3GFXaSoBpXzWDuK0Hk1+6adDS9CiKbwjYDvpn45JQK2smoAc6a2VY
	 eErD63YTFAMlCDYm6FJgNySrYvH+No6aVUFpqIX5qhZPFESl8PQFdPQEsPG3OxXWwtSuk
	 G0XSkNNJGtgjCNEysic6t6fDy9BFeQvpOPpjOjg+euJ952hOC92bm0QHskWsIg3jDG4zj
	 +JKL8NmJL4RX4djBHmx3I3+cCO+OT5rQBC9ioy2ltJLV7p3a78i87Q5ec2aOhGWXy3wz4
	 1Xt4APCyLhvbOCzRg6SW/rSkviDwlQS/0tEgN3sfMA+Qom+j5JWnp8iu+QGYauu04RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FphJ2oiI;
	arc=none smtp.remote-ip=198.175.65.10
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFA9606A31C
	for <linux-cxl@vger.kernel.org>; Wed, 18 Nov 2026 16:26:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4FFA9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FphJ2oiI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795019195; x=1826555195;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=2tSwDL19yIdc4RxRrE+3d0fagr7v5FtO6kgbG04ucHQ=;
  b=FphJ2oiIheKI69Ot6I16gToC4RirYocVqU8V+C3UzDy9HtBx/Swb55zR
   rKPDqtqBK+EIm9aDLbEk+lZE0jYMW/nyGByH09xdbZyzG6j46li5Xd9uX
   EtOnb1EhK1QFPm/HunGtsX4nvKYZ6Zu2zZGh2myqMBqo4xsdikW+jKhE4
   ZN+TPFaMQn0QQAhcoj94MC2il6Nq/Ub6ue7/EWO2QaEPj1QxXMb/8TYKr
   weLP3keUArzehtaHUYb/ItjFFkrKl0x72fMFOAHjgrCe26LfxlgDSjx/l
   JJJeTv0yV12WCW9B6/5lieMHbvXaEu7NoUPOOIDQZ0JM7CzQ4WWsp33ij
   g==;
X-CSE-ConnectionGUID: VVE10ZmxTTinwA7rTq+XBA==
X-CSE-MsgGUID: rzDmutGpQCK5fJwcvvcQZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11970"; a="3755506"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3755506"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 08:26:35 -0800
X-CSE-ConnectionGUID: 344IC3uITiG7Y0hhI/bVRA==
X-CSE-MsgGUID: sGKVsZb1SeCer38VSwdNDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10579672"
Received: from jjgreens-desk24.amr.corp.intel.com (HELO [10.125.109.2]) ([10.125.109.2])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 08:26:34 -0800
Message-ID: <2887b191-6c0e-4754-a45f-13c8d0e49ac4@intel.com>
Date: Wed, 18 Nov 2026 09:26:33 -0700
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ndctl PATCH] test/cxl-security.sh: test dimm unlock with a large
 serial number
To: Alison Schofield <alison.schofield@intel.com>, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org
References: <20260702003407.1611731-1-alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260702003407.1611731-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/1/26 5:34 PM, Alison Schofield wrote:
> The existing CXL unlock test exposed the hexadecimal-vs-decimal key
> description mismatch once cxl_test mock serial numbers were extended
> to 10 and above. Serials with bit 63 set expose a second formatting
> problem in that the kernel formats the decimal serial as signed,
> rendering it as a negative value.
> 
> Extend the existing "unlock dimm" test to repeat the unlock against a
> mock memdev with a full-width serial that has bit 63 set. Refactor the
> common unlock sequence into an unlock_dimm() helper so the signedness
> case follows the same test flow as the original key lookup case.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  test/cxl-security | 24 ++++++++++++++++++++++++
>  test/security.sh  | 16 ++++++++++++++--
>  2 files changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/test/cxl-security b/test/cxl-security
> index 9a28ffd82b0b..39b7e001ce08 100644
> --- a/test/cxl-security
> +++ b/test/cxl-security
> @@ -9,6 +9,30 @@ detect()
>  	[ -n "$id" ] || err "$LINENO"
>  }
>  
> +# Select the mock memdev whose serial has bit 63 set. Match on the hex
> +# spelling of 'id' because the value exceeds signed 64-bit shell arithmetic.
> +# A 16-digit hex value with a leading nibble of 8-f has bit 63 set.
> +detect_big_serial()
> +{
> +	local d i hex
> +
> +	dev=""
> +	for d in $($NDCTL list -b "$CXL_TEST_BUS" -D | jq -r '.[].dev'); do
> +		i="$($NDCTL list -b "$CXL_TEST_BUS" -D -d "$d" | \
> +			jq -r '.[0].id')"
> +		hex="$(printf '%x' "$i" 2>/dev/null)" || continue
> +		case "${#hex}:${hex:0:1}" in
> +		16:[89a-fA-F])
> +			dev="$d"
> +			id="$i"
> +			break
> +			;;
> +		esac
> +	done
> +
> +	[ -n "$dev" ] || err "$LINENO: no serial with bit 63 set found"
> +}
> +
>  lock_dimm()
>  {
>  	$NDCTL disable-dimm "$dev"
> diff --git a/test/security.sh b/test/security.sh
> index d3a840c23276..72bb570142ed 100755
> --- a/test/security.sh
> +++ b/test/security.sh
> @@ -144,7 +144,7 @@ test_3_security_setup_and_erase()
>  	erase_security
>  }
>  
> -test_4_security_unlock()
> +unlock_dimm()
>  {
>  	setup_passphrase
>  	lock_dimm
> @@ -158,6 +158,18 @@ test_4_security_unlock()
>  	remove_passphrase
>  }
>  
> +test_4_security_unlock()
> +{
> +	unlock_dimm
> +
> +	if [ "$1" = "cxl" ] && check_min_kver "7.3"; then
> +		detect_big_serial
> +		unlock_dimm
> +		# Restore the default device selection for later tests.
> +		detect
> +	fi
> +}
> +
>  # This should always be the last nvdimm security test.
>  # with security frozen, nfit_test must be removed and is no longer usable
>  test_5_security_freeze()
> @@ -241,7 +253,7 @@ test_2_security_setup_and_update
>  echo "Test 3, security setup and erase"
>  test_3_security_setup_and_erase
>  echo "Test 4, unlock dimm"
> -test_4_security_unlock
> +test_4_security_unlock "$1"
>  
>  # Freeze should always be the last nvdimm security test because it locks
>  # security state and require nfit_test module unload. However, this does
> 
> base-commit: 5fcbbee57319e718bf522436ea6595bd0f71296c

