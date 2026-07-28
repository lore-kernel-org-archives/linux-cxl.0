Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F174B4964F
	for <linux-cxl@vger.kernel.org>; Tue, 28 Jul 2026 02:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785204992; cv=none; b=TqaXcOEkrJiEKZEQEHKcyI9jiwSvSunXoCDuN0SRknOA3y3tb+NBN1919vP0lrUE36lzMcHTbuH9rbM1h2hm52vENNzHtTv7zlqoh5Q4XCU0XPUtDkJlqKiiHwMBdq6PRW2hqudy5LkYXpcc4oO4yooRCBHh4CjuiykbHp01o+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785204992; c=relaxed/simple;
	bh=e9B2XuUbw9gkM4v5b7dH80+GKhEcyobHN2CEWZ/qlFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HCFopyHfPRu2yvIXdhpOHUMzrTQK3xt8P7DbhAbdgIrS9eXVFu5U+5NhnHyeCCvXKVMvrSdZBaXXwjb47zsLL09AQEAs0GtUmFqkm8cAnGA4Yj6U+VRAMz7hOZrEwNeQg4GRe5MeIMe4LlV10JFZbg5hY/If7/V8PY9de0WJDB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SMRhj/oJ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SMRhj/oJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785204990; x=1816740990;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e9B2XuUbw9gkM4v5b7dH80+GKhEcyobHN2CEWZ/qlFo=;
  b=SMRhj/oJUfOqXKwr4bsmKk3U04oBaZsw4pFDStD31GFrjpBk0uBIWy6x
   gHqxCeI4CxDEB8uhY5aXAaIDcnhHn25aMbrpMqegGnZp07RsPQdMfqerY
   FrEvWT2OI7QjW9Xiym5kknP5fiqMVH8qMhg908QhD4dL+Yabn4pHkryby
   PM9iPpSHvmkvYFMDjLFISQSHTJSMXFMvp9KLgXmpKLb+QZ3vzt6TTEizI
   8KatA9BlNg3+NWWWvHthp4i7LREcQItaM8pO721SVTe1kz/fci3EBK6fC
   9dmzQmIUt++ZdC4MM0KAysWOCHjwXso9qTygNjZh6lT36p200YS7T1NK3
   Q==;
X-CSE-ConnectionGUID: YuK8GY+RRJ+dhdZIvHIsoQ==
X-CSE-MsgGUID: exCZLP14Q6Cw6U5Mub7z8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11858"; a="96137614"
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="96137614"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 19:16:29 -0700
X-CSE-ConnectionGUID: oGXMZR70S+qq5l83EgtJTQ==
X-CSE-MsgGUID: 1YvSg3d4QPy8vyNO8xU2UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,189,1779174000"; 
   d="scan'208";a="258305617"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2026 19:16:29 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: jic23@kernel.org,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 4/6] hw/cxl: free in-flight sanitize state on reset
Date: Tue, 28 Jul 2026 10:15:35 +0800
Message-ID: <20260728021535.514056-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <14f4c087-6d7b-4839-88d5-8134b8120007@oss.qualcomm.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Philippe,

Thanks for the review!

Will do both in v3 -- a cxl_destroy_mailbox_t3() teardown counterpart
called from the reset path and ct3_exit(), with the sanitize discard
folded into it via a helper shared with __do_sanitize().

One naming tweak: the helper is cxl_discard_media_op_sanitize() rather
than "cancel", since __do_sanitize()'s normal completion path shares it.

Many thanks,
Junjie
