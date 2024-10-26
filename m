Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356FE18AEA;
	Sat, 26 Oct 2024 00:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729903627; cv=none; b=FQz+WctL/wNZkUrq/Wj7CblbbyLGsrdZsCMwTZmXmbec0i6xW0jioAvr82I16GwcLyY+/Nv00nhX0tO5/y3el0O8mOG1YWcvVhmTBa33OkgV619Y/ESErpXww4uTpJKCCQqLN7bXRHaPCVYnb7MY4ijf8vOn0cbIF/pEOkRcubo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729903627; c=relaxed/simple;
	bh=CYq5HpgIrQv2pGkd8rxDhLdRv/q0A6ZcvsaZcaUGFaw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e9q419BFosoA7/qD8+SGxBPdtS1DymZkksAuVLYqN0aodxr5xs/YyI6huRw6q0JS2lWK6FMnhJLUyvMFsMIKBz0A8OieW7IalO70MreymMFjruPQuHjZb5qK6bK8jN6J6FY599F/tV6XK8MhpfEjvF9eg5m50AlelIcy//UTmV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h54q4A59; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h54q4A59"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729903626; x=1761439626;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=CYq5HpgIrQv2pGkd8rxDhLdRv/q0A6ZcvsaZcaUGFaw=;
  b=h54q4A593C+OFNoFD0W9HLPGxWoWVLRluTB6xcnS/8XjH4q2s5aiZsGg
   TAPr5kVZXLfz/BY1v8D+2Pg/5N78Isf3HuX8hZtpnUX0FWlfff3E+l0cX
   JfHsFl/un3qm4QlXXPduSOhDI3u5v5X9XkX70qGO09D7vIBBYCUUOK3rZ
   1n3VEHd06ENoiGCQnCCMK4HuMDkNrfz1dMwHIApSxTZW+ukamFaexZrdJ
   fTQcnJdGmiw42r/EsDT2cIKPqTHbvBcUzBcCX0kXtGnwZ/YILMCLzckvr
   LWd5gbmydsmHlGdrTVyRPK90erz6XIXvH79d+VrbXAc/PmnN8K9XV3QsW
   A==;
X-CSE-ConnectionGUID: jdlQAYs1QkuTzxBJeaipeQ==
X-CSE-MsgGUID: AZFgT++pS5KgJDYOx2G0Yg==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="40974461"
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="40974461"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 17:47:06 -0700
X-CSE-ConnectionGUID: +Z8cFED7S1+gWJ+riMfkIA==
X-CSE-MsgGUID: 8udnAxQWSZevHBquho7C4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,233,1725346800"; 
   d="scan'208";a="85851651"
Received: from kinlongk-mobl1.amr.corp.intel.com (HELO localhost) ([10.125.111.138])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 17:47:03 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 25 Oct 2024 19:46:55 -0500
Subject: [PATCH v2 3/4] printf: Add print format (%pra) for struct range
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-cxl-pra-v2-3-123a825daba2@intel.com>
References: <20241025-cxl-pra-v2-0-123a825daba2@intel.com>
In-Reply-To: <20241025-cxl-pra-v2-0-123a825daba2@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jonathan Corbet <corbet@lwn.net>, Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: Fan Ni <fan.ni@samsung.com>, Bagas Sanjaya <bagasdotme@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-cxl@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729903614; l=7399;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=CYq5HpgIrQv2pGkd8rxDhLdRv/q0A6ZcvsaZcaUGFaw=;
 b=qtz3hNzMow+Lxg8+EBPNFkW8H1wSBMiDCfDPxA7SWkZi+JcaX/4JoxhIyYEG8Ew9KKhBkbJdu
 iW4Y5tcS1j2Ct2LZ4yrFkw11qBURMPQktH0Y93ZsikzBwYCH+cc9/QV
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

The use of struct range in the CXL subsystem is growing.  In particular,
the addition of Dynamic Capacity devices uses struct range in a number
of places which are reported in debug and error messages.

To wit requiring the printing of the start/end fields in each print
became cumbersome.  Dan Williams mentions in [1] that it might be time
to have a print specifier for struct range similar to struct resource

A few alternatives were considered including '%par', '%r', and '%pn'.
%pra follows that struct range is similar to struct resource (%p[rR])
but needs to be different.  Based on discussions with Petr and Andy
'%pra' was chosen.[2]

Andy also suggested to keep the range prints similar to struct resource
though combined code.  Add hex_range() to handle printing for both
pointer types.

Finally introduce DEFINE_RANGE() as a parallel to DEFINE_RES_*() and use
it in the tests.

Cc: Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org (open list)
Link: https://lore.kernel.org/all/663922b475e50_d54d72945b@dwillia2-xfh.jf.intel.com.notmuch/ [1]
Link: https://lore.kernel.org/all/66cea3bf3332f_f937b29424@iweiny-mobl.notmuch/ [2]
Suggested-by: "Dan Williams" <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes:
[Andy: s/resource_and_range/resource_or_range/]
---
 Documentation/core-api/printk-formats.rst | 13 +++++++
 include/linux/range.h                     |  6 ++++
 lib/test_printf.c                         | 17 +++++++++
 lib/vsprintf.c                            | 57 +++++++++++++++++++++++++++----
 4 files changed, 87 insertions(+), 6 deletions(-)

diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
index 552f51046cf3..ecccc0473da9 100644
--- a/Documentation/core-api/printk-formats.rst
+++ b/Documentation/core-api/printk-formats.rst
@@ -236,6 +236,19 @@ width of the CPU data path.
 
 Passed by reference.
 
+Struct Range
+------------
+
+::
+
+	%pra    [range 0x0000000060000000-0x000000006fffffff] or
+		[range 0x0000000060000000]
+
+For printing struct range.  struct range holds an arbitrary range of u64
+values.  If start is equal to end only print the start value.
+
+Passed by reference.
+
 DMA address types dma_addr_t
 ----------------------------
 
diff --git a/include/linux/range.h b/include/linux/range.h
index 6ad0b73cb7ad..1358d4b1807a 100644
--- a/include/linux/range.h
+++ b/include/linux/range.h
@@ -31,4 +31,10 @@ int clean_sort_range(struct range *range, int az);
 
 void sort_range(struct range *range, int nr_range);
 
+#define DEFINE_RANGE(_start, _end)		\
+(struct range) {				\
+		.start = (_start),		\
+		.end = (_end),			\
+	}
+
 #endif
diff --git a/lib/test_printf.c b/lib/test_printf.c
index 5afdf5efc627..59dbe4f9a4cb 100644
--- a/lib/test_printf.c
+++ b/lib/test_printf.c
@@ -432,6 +432,22 @@ struct_resource(void)
 	     "%pR", &test_resource);
 }
 
+static void __init
+struct_range(void)
+{
+	struct range test_range = DEFINE_RANGE(0xc0ffee00ba5eba11,
+					       0xc0ffee00ba5eba11);
+	test("[range 0xc0ffee00ba5eba11]", "%pra", &test_range);
+
+	test_range = DEFINE_RANGE(0xc0ffee, 0xba5eba11);
+	test("[range 0x0000000000c0ffee-0x00000000ba5eba11]",
+	     "%pra", &test_range);
+
+	test_range = DEFINE_RANGE(0xba5eba11, 0xc0ffee);
+	test("[range 0x00000000ba5eba11-0x0000000000c0ffee]",
+	     "%pra", &test_range);
+}
+
 static void __init
 addr(void)
 {
@@ -807,6 +823,7 @@ test_pointer(void)
 	symbol_ptr();
 	kernel_ptr();
 	struct_resource();
+	struct_range();
 	addr();
 	escaped_str();
 	hex_string();
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 09f022ba1c05..9e76350bd77d 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1039,6 +1039,20 @@ static const struct printf_spec default_dec04_spec = {
 	.flags = ZEROPAD,
 };
 
+static noinline_for_stack
+char *hex_range(char *buf, char *end, u64 start_val, u64 end_val,
+		struct printf_spec spec)
+{
+	buf = number(buf, end, start_val, spec);
+	if (start_val == end_val)
+		return buf;
+
+	if (buf < end)
+		*buf = '-';
+	++buf;
+	return number(buf, end, end_val, spec);
+}
+
 static noinline_for_stack
 char *resource_string(char *buf, char *end, struct resource *res,
 		      struct printf_spec spec, const char *fmt)
@@ -1115,11 +1129,7 @@ char *resource_string(char *buf, char *end, struct resource *res,
 		p = string_nocheck(p, pend, "size ", str_spec);
 		p = number(p, pend, resource_size(res), *specp);
 	} else {
-		p = number(p, pend, res->start, *specp);
-		if (res->start != res->end) {
-			*p++ = '-';
-			p = number(p, pend, res->end, *specp);
-		}
+		p = hex_range(p, pend, res->start, res->end, *specp);
 	}
 	if (decode) {
 		if (res->flags & IORESOURCE_MEM_64)
@@ -1140,6 +1150,31 @@ char *resource_string(char *buf, char *end, struct resource *res,
 	return string_nocheck(buf, end, sym, spec);
 }
 
+static noinline_for_stack
+char *range_string(char *buf, char *end, const struct range *range,
+		   struct printf_spec spec, const char *fmt)
+{
+	char sym[sizeof("[range 0x0123456789abcdef-0x0123456789abcdef]")];
+	char *p = sym, *pend = sym + sizeof(sym);
+
+	struct printf_spec range_spec = {
+		.field_width = 2 + 2 * sizeof(range->start), /* 0x + 2 * 8 */
+		.flags = SPECIAL | SMALL | ZEROPAD,
+		.base = 16,
+		.precision = -1,
+	};
+
+	if (check_pointer(&buf, end, range, spec))
+		return buf;
+
+	p = string_nocheck(p, pend, "[range ", default_str_spec);
+	p = hex_range(p, pend, range->start, range->end, range_spec);
+	*p++ = ']';
+	*p = '\0';
+
+	return string_nocheck(buf, end, sym, spec);
+}
+
 static noinline_for_stack
 char *hex_string(char *buf, char *end, u8 *addr, struct printf_spec spec,
 		 const char *fmt)
@@ -2229,6 +2264,15 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
 	return widen_string(buf, buf - buf_start, end, spec);
 }
 
+static noinline_for_stack
+char *resource_or_range(const char *fmt, char *buf, char *end, void *ptr,
+			struct printf_spec spec)
+{
+	if (*fmt == 'r' && fmt[1] == 'a')
+		return range_string(buf, end, ptr, spec, fmt);
+	return resource_string(buf, end, ptr, spec, fmt);
+}
+
 int __init no_hash_pointers_enable(char *str)
 {
 	if (no_hash_pointers)
@@ -2277,6 +2321,7 @@ char *rust_fmt_argument(char *buf, char *end, void *ptr);
  * - 'Bb' as above with module build ID (for use in backtraces)
  * - 'R' For decoded struct resource, e.g., [mem 0x0-0x1f 64bit pref]
  * - 'r' For raw struct resource, e.g., [mem 0x0-0x1f flags 0x201]
+ * - 'ra' For struct ranges, e.g., [range 0x0000000000000000 - 0x00000000000000ff]
  * - 'b[l]' For a bitmap, the number of bits is determined by the field
  *       width which must be explicitly specified either as part of the
  *       format string '%32b[l]' or through '%*b[l]', [l] selects
@@ -2401,7 +2446,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 		return symbol_string(buf, end, ptr, spec, fmt);
 	case 'R':
 	case 'r':
-		return resource_string(buf, end, ptr, spec, fmt);
+		return resource_or_range(fmt, buf, end, ptr, spec);
 	case 'h':
 		return hex_string(buf, end, ptr, spec, fmt);
 	case 'b':

-- 
2.47.0

